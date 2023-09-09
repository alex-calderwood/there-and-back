package com.stephengware.java.planware.graph;

import java.util.HashMap;
import java.util.Iterator;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.logic.ClauseIterator;
import com.stephengware.java.planware.logic.ClauseLiteral;
import com.stephengware.java.planware.logic.ConditionalExpression;
import com.stephengware.java.planware.logic.Conjunction;
import com.stephengware.java.planware.logic.DNFIterator;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.Negation;

public class ProblemGraph {

	public final NodeList<LiteralNode> literalNodes = new NodeList<>();
	private final HashMap<Literal, LiteralNode> literalNodeMap = new HashMap<>();
	private final NodeList<LiteralNode> negativePreconditions = new NodeList<>();
	
	public final NodeList<StepNode> stepNodes = new NodeList<>();
	private final HashMap<Step, StepNode> stepNodeMap = new HashMap<>();
	
	public final NodeList<AxiomNode> axiomNodes = new NodeList<>();
	private final HashMap<Axiom, AxiomNode> axiomNodeMap = new HashMap<>();
	
	public final NodeList<GoalNode> goalNodes = new NodeList<>();
	private final HashMap<Expression, GoalNode> goalNodeMap = new HashMap<>();
	
	Node firstReset = null;
	final NodeList<SatisfiableNode> alwaysSatisfied = new NodeList<>();
	
	public LiteralNode getLiteralNode(Literal literal){
		return literalNodeMap.get(literal);
	}
	
	public LiteralNode makeLiteralNode(Literal literal){
		LiteralNode node = getLiteralNode(literal);
		if(node == null){
			node = constructLiteralNode(literal);
			registerLiteralNode(node);
			node.negation = getLiteralNode(literal.negate());
			if(node.negation != null)
				node.negation.negation = node;
		}
		return node;
	}
	
	protected LiteralNode constructLiteralNode(Literal literal){
		return new LiteralNode(this, literal);
	}
	
	protected void registerLiteralNode(LiteralNode node){
		if(literalNodeMap.containsKey(node.literal))
			return;
		literalNodeMap.put(node.literal, node);
		((NodeList<LiteralNode>) literalNodes).add(node);
	}
	
	protected void makePreconditionNodes(Expression testable, SatisfiableNode child){
		if(!testable.isTestable())
			throw new IllegalArgumentException("The expression \"" + testable + "\" is not testable.");
		for(DNFIterator clauses = new DNFIterator(testable); clauses.hasNext();)
			child.parents.add(makePreconditionNode(clauses.next().clause, child));
		if(child.parents.size() == 0)
			alwaysSatisfied.add(child);
		if(child.isSatisfied())
			child.satisfy();
	}
	
	protected PreconditionNode makePreconditionNode(Expression clause, SatisfiableNode child){
		if(!clause.isTestable())
			throw new IllegalArgumentException("The expression \"" + clause + "\" is not testable.");
		PreconditionNode node = constructPreconditionNode(clause, child);
		if(clause instanceof Conjunction)
			for(ClauseIterator literals = new ClauseIterator(clause); literals.hasNext();)
				linkLiteralToPrecondition(makeLiteralNode(literals.next().literal), node);
		else if(clause instanceof Literal)
			linkLiteralToPrecondition(makeLiteralNode((Literal) clause), node);
		else
			throw new IllegalArgumentException("The expression \"" + clause + "\" is not a conjunctive clause or literal.");
		return node;
	}
	
	private final void linkLiteralToPrecondition(LiteralNode literalNode, PreconditionNode preconditionNode){
		preconditionNode.parents.add(literalNode);
		literalNode.children.add(preconditionNode);
		if(literalNode.children.size() == 1 && literalNode.literal instanceof Negation)
			negativePreconditions.add(literalNode);
	}
	
	protected PreconditionNode constructPreconditionNode(Expression clause, SatisfiableNode child){
		return new PreconditionNode(this, clause, child);
	}
	
	protected void makeEffectNodes(ChangeNode parent, Expression imposable){
		if(!imposable.isImposable())
			throw new IllegalArgumentException("The expression \"" + imposable + "\" is not imposable.");
		for(DNFIterator clauses = new DNFIterator(imposable); clauses.hasNext();)
			for(Iterator<ClauseLiteral> literals = clauses.next(); literals.hasNext();)
				makeEffectNode(parent, literals.next().expression);
	}
	
	protected EffectNode makeEffectNode(ChangeNode parent, Expression effect){
		if(!effect.isImposable())
			throw new IllegalArgumentException("The expression \"" + effect + "\" is not imposable.");
		for(int i=0; i<parent.children.size(); i++)
			if(parent.children.get(i).effect.equals(effect))
				return parent.children.get(i);
		Expression condition = null;
		Expression literal = effect;
		if(effect instanceof ConditionalExpression){
			ConditionalExpression condExp = (ConditionalExpression) effect;
			condition = condExp.condition;
			literal = condExp.effect;
		}
		LiteralNode child;
		if(literal instanceof Literal)
			child = makeLiteralNode((Literal) literal);
		else
			throw new IllegalArgumentException("The expression \"" + literal + "\" is not a literal.");
		EffectNode node = constructEffectNode(parent, effect, child);
		parent.children.add(node);
		node.child.parents.add(node);
		if(condition != null)
			makePreconditionNodes(condition, node);
		return node;
	}
	
	protected EffectNode constructEffectNode(ChangeNode parent, Expression effect, LiteralNode child){
		return new EffectNode(this, parent, effect, child);
	}
	
	public StepNode getStepNode(Step step){
		return stepNodeMap.get(step);
	}
	
	public StepNode makeStepNode(Step step){
		StepNode node = getStepNode(step);
		if(node == null){
			node = constructStepNode(step);
			registerStepNode(node);
			makePreconditionNodes(step.precondition, node);
			makeEffectNodes(node, step.effect);
		}
		return node;
	}
	
	protected StepNode constructStepNode(Step step){
		return new StepNode(this, step);
	}
	
	protected void registerStepNode(StepNode node){
		if(stepNodeMap.containsKey(node.step))
			return;
		stepNodeMap.put(node.step, node);
		((NodeList<StepNode>) stepNodes).add(node);
	}
	
	public AxiomNode getAxiomNode(Axiom axiom){
		return axiomNodeMap.get(axiom);
	}
	
	public AxiomNode makeAxiomNode(Axiom axiom){
		AxiomNode node = getAxiomNode(axiom);
		if(node == null){
			node = constructAxiomNode(axiom);
			registerAxiomNode(node);
			makePreconditionNodes(axiom.context, node);
			makeEffectNodes(node, axiom.implies);
		}
		return node;
	}
	
	protected AxiomNode constructAxiomNode(Axiom axiom){
		return new AxiomNode(this, axiom);
	}
	
	protected void registerAxiomNode(AxiomNode node){
		if(axiomNodeMap.containsKey(node.axiom))
			return;
		axiomNodeMap.put(node.axiom, node);
		((NodeList<AxiomNode>) axiomNodes).add(node);
	}
	
	public GoalNode getGoalNode(Expression goal){
		return goalNodeMap.get(goal);
	}
	
	public GoalNode makeGoalNode(Expression goal){
		if(!goal.isTestable())
			throw new IllegalArgumentException("The expression \"" + goal + "\" is not testable.");
		GoalNode node = getGoalNode(goal);
		if(node == null){
			node = constructGoalNode(goal);
			registerGoalNode(node);
			makePreconditionNodes(goal, node);
		}
		return node;
	}
	
	protected GoalNode constructGoalNode(Expression goal){
		return new GoalNode(this, goal);
	}
	
	protected void registerGoalNode(GoalNode node){
		if(goalNodeMap.containsKey(node.expression))
			return;
		goalNodeMap.put(node.expression, node);
		((NodeList<GoalNode>) goalNodes).add(node);
	}
	
	public void reset(){
		while(firstReset != null)
			firstReset.reset();
		for(int i=0; i<alwaysSatisfied.size(); i++)
			if(alwaysSatisfied.get(i).isSatisfied())
				alwaysSatisfied.get(i).satisfy();
	}
	
	public void initialize(State state){
		reset();
		LiteralNode node = getLiteralNode(Expression.TRUE);
		if(node != null)
			node.activate();
		for(Literal literal : state){
			node = getLiteralNode(literal);
			if(node != null)
				node.activate();
		}
		for(int i=0; i<negativePreconditions.size(); i++){
			LiteralNode negative = negativePreconditions.get(i);
			LiteralNode positive = negative.getNegation();
			if(positive == null || !positive.isActive())
				negative.activate();
		}
	}
}