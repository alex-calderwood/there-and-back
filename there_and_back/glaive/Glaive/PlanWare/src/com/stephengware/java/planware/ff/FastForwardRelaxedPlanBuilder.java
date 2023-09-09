package com.stephengware.java.planware.ff;

import java.util.Arrays;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;

import com.stephengware.java.planware.State;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.graph.ChangeNode;
import com.stephengware.java.planware.graph.PreconditionNode;
import com.stephengware.java.planware.graph.SatisfiableNode;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.pg.EffectNode;
import com.stephengware.java.planware.pg.GoalNode;
import com.stephengware.java.planware.pg.LiteralNode;
import com.stephengware.java.planware.pg.PlanGraph;
import com.stephengware.java.planware.pg.StepNode;
import com.stephengware.java.planware.util.ArrayIterable;
import com.stephengware.java.planware.util.ArrayIterator;
import com.stephengware.java.planware.util.CountableIterable;

public class FastForwardRelaxedPlanBuilder {

	protected final PlanGraph planGraph;
	protected final GoalNode goal;
	private final HashSet<LiteralNode> goals = new HashSet<>();
	private final HashSet<ChangeNode> changeNodes = new HashSet<>();
	private int stepCount = 0;
	private StepNode[] plan = new StepNode[50];
	
	public FastForwardRelaxedPlanBuilder(PlanGraph planGraph, Expression goal){
		this.planGraph = planGraph;
		this.goal = planGraph.makeGoalNode(goal);
	}
	
	//-------------------------------------------------------------------------
	// Node Evaluation
	//-------------------------------------------------------------------------
	
	final void evaluate(FastForwardSearchNode node){
		initialize(node.getState());
		satisfy(goal);
		node.relaxedPlan = getRelaxedPlan();
		node.nextSteps = getNextSteps();
	}
	
	//-------------------------------------------------------------------------
	// Relaxed Plan Extraction
	//-------------------------------------------------------------------------
	
	public void initialize(State initial){
		goals.clear();
		changeNodes.clear();
		stepCount = 0;
		planGraph.initialize(initial);
	}
	
	public boolean satisfy(Expression goal){
		return satisfy(planGraph.makeGoalNode(goal));
	}
	
	protected boolean satisfy(GoalNode goal){
		while(!goal.isActive() && !planGraph.hasLeveledOff())
			planGraph.extend();
		if(goal.isActive()){
			satisfy(choosePrecondition(goal));
			return true;
		}
		else
			return false;
	}
	
	protected PreconditionNode choosePrecondition(SatisfiableNode satisfiable){
		PreconditionNode best = null;
		for(int i=0; i<satisfiable.parents.size(); i++){
			PreconditionNode p = satisfiable.parents.get(i);
			if(mayChoose(p, satisfiable)){
				if(best == null)
					best = p;
				else if(compare(p, best) < 0)
					best = p;
			}
		}
		return best;
	}
	
	protected boolean mayChoose(PreconditionNode precondition, SatisfiableNode satisfiable){
		return precondition.isActive();
	}
	
	protected int compare(PreconditionNode p1, PreconditionNode p2){
		int difference = preconditionCost(p1) - preconditionCost(p2);
		if(difference == 0)
			difference = getLevel(p1) - getLevel(p2);
		return difference;
	}
	
	protected void satisfy(PreconditionNode precondition){
		if(precondition == null)
			return;
		for(int i=0; i<precondition.parents.size(); i++)
			satisfy((LiteralNode) precondition.parents.get(i));
	}
	
	protected void satisfy(LiteralNode literal){
		if(literal.getLevel() == 0 || !goals.add(literal))
			return;
		EffectNode provider = chooseEffect(literal);
		satisfy(choosePrecondition(provider));
		if(provider.parent instanceof StepNode)
			addStepToPlan((StepNode) provider.parent);
		else if(changeNodes.add(provider.parent))
			satisfy(choosePrecondition(provider.parent));
	}
	
	protected EffectNode chooseEffect(LiteralNode literal){
		EffectNode best = null;
		for(int i=0; i<literal.parents.size(); i++){
			EffectNode e = (EffectNode) literal.parents.get(i);
			if(mayChoose(e, literal)){
				if(best == null)
					best = e;
				else if(compare(e, best) < 0)
					best = e;
			}
		}
		return best;
	}
	
	protected boolean mayChoose(EffectNode effect, LiteralNode literal){
		return effect.isActive() && effect.getLevel() <= literal.getLevel() && !hasPrecondition(effect, literal);
	}
	
	protected int compare(EffectNode e1, EffectNode e2){
		int difference = effectCost(e1) - effectCost(e2);
		if(difference == 0)
			difference = e1.getLevel() - e2.getLevel();
		return difference;
	}
	
	protected void addStepToPlan(StepNode step){
		if(changeNodes.add(step)){
			stepCount++;
			if(stepCount == plan.length)
				plan = Arrays.copyOf(plan, plan.length * 2);
			plan[stepCount - 1] = step;
			satisfy(choosePrecondition(step));
		}
	}
	
	protected boolean planContains(ChangeNode node){
		return changeNodes.contains(node);
	}
	
	protected boolean planContains(LiteralNode literal){
		return goals.contains(literal);
	}
	
	public CountableIterable<? extends Step> getRelaxedPlan(){
		return new ArrayIterable<Step>(relaxedPlanToArray(new Step[stepCount]));
	}
	
	private static final Comparator<StepNode> SORT_BY_LEVEL = new Comparator<StepNode>(){

		@Override
		public int compare(StepNode s1, StepNode s2){
			return s1.getLevel() - s2.getLevel();
		}
	};
	
	@SuppressWarnings("unchecked")
	protected <S extends Step> S[] relaxedPlanToArray(S[] array){
		if(array.length < stepCount)
			array = Arrays.copyOf(array, stepCount);
		Arrays.sort(plan, 0, stepCount, SORT_BY_LEVEL);
		for(int i=0; i<stepCount; i++)
			array[i] = (S) plan[i].step;
		return array;
	}
	
	public Iterator<? extends Step> getNextSteps(){
		if(planGraph.countLevels() == 1)
			planGraph.extend();
		Step[] nextSteps = new Step[planGraph.countStepsAtLevel(1)];
		int front = 0;
		int back = nextSteps.length - 1;
		for(Iterator<StepNode> iterator = planGraph.getStepsAtLevel(1); iterator.hasNext();){
			StepNode node = iterator.next();
			if(changeNodes.contains(node)){
				nextSteps[front] = node.step;
				front++;
			}
			else{
				nextSteps[back] = node.step;
				back--;
			}
		}
		return new ArrayIterator<>(nextSteps);
	}
	
	//-------------------------------------------------------------------------
	// Utility
	//-------------------------------------------------------------------------
	
	private static final int getLevel(PreconditionNode preconditionNode){
		int level = 0;
		for(int i=0; i<preconditionNode.parents.size(); i++)
			level = Math.max(level, ((LiteralNode) preconditionNode.parents.get(i)).getLevel());
		return level;
	}
	
	private static final boolean hasPrecondition(EffectNode node, LiteralNode literal){
		return findPrecondition(node, literal) || findPrecondition(node.parent, literal);
	}
	
	private static final boolean findPrecondition(SatisfiableNode node, LiteralNode literal){
		for(int i=0; i<node.parents.size(); i++){
			PreconditionNode clause = node.parents.get(i);
			for(int j=0; j<clause.parents.size(); j++)
				if(clause.parents.get(j) == literal)
					return true;
		}
		return false;
	}
	
	private final int effectCost(EffectNode e){
		return satisfiableCost(e.parent) + satisfiableCost(e);
	}
	
	private final int satisfiableCost(SatisfiableNode satisfiable){
		if(satisfiable.parents.size() == 0)
			return 0;
		if(satisfiable instanceof ChangeNode && changeNodes.contains(satisfiable))
			return 0;
		int min = Integer.MAX_VALUE;
		for(int i=0; i<satisfiable.parents.size(); i++){
			int cost = preconditionCost(satisfiable.parents.get(i));
			if(cost < min)
				min = cost;
		}
		return min;
	}
	
	private final int preconditionCost(PreconditionNode p){
		int cost = 0;
		for(int i=0; i<p.parents.size(); i++){
			LiteralNode literal = (LiteralNode) p.parents.get(i);
			if(literal.getLevel() > 0 && !goals.contains(p.parents.get(i)))
				cost++;
		}
		return cost;
	}
}
