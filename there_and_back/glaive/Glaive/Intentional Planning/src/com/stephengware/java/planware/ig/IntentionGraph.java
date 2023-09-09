package com.stephengware.java.planware.ig;

import java.util.HashMap;
import java.util.LinkedHashSet;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Intention;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.pg.LiteralNode;
import com.stephengware.java.planware.pg.PlanGraph;
import com.stephengware.java.planware.ss.IntentionalStateSpace;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionGraph extends PlanGraph {
	
	final IntentionalStateSpace space;
	
	public IntentionGraph(IntentionalStateSpace space){
		super(space);
		this.space = space;
		for(Literal literal : space.problem.getInitialState().collect(Literal.class))
			makeLiteralNode(literal);
		HashMap<StepNode, LinkedHashSet<Motivation>> motivations = new HashMap<>();
		for(Intention intention : space.collect(Intention.class)){
			IntentionNode intentionNode = (IntentionNode) makeLiteralNode(intention);
			GoalNode goalNode = makeGoalNode(intention.goal);
			goalNode.findIntentionalAncestors((Constant) intention.agent);
			GoalTree goalTree = goalNode.intentionalAncestors.get(intention.agent);
			for(int i=0; i<goalTree.steps.length; i++){
				StepNode step = goalTree.steps[i];
				LinkedHashSet<Motivation> intentions = motivations.get(step);
				if(intentions == null){
					intentions = new LinkedHashSet<>();
					motivations.put(step, intentions);
				}
				intentions.add(new Motivation(intentionNode, goalTree.distances[i]));
			}
		}
		for(int i=0; i<stepNodes.size(); i++){
			StepNode stepNode = (StepNode) stepNodes.get(i);
			LinkedHashSet<Motivation> intentions = motivations.get(stepNode);
			if(intentions == null)
				intentions = new LinkedHashSet<>();
			stepNode.motivations = new ImmutableSet<>(intentions, Motivation.class);
		}
	}
	
	@Override
	protected LiteralNode constructLiteralNode(Literal literal){
		if(literal instanceof Intention)
			return new IntentionNode(this, (Intention) literal);
		else
			return super.constructLiteralNode(literal);
	}
	
	@Override
	public StepNode getStepNode(Step step){
		return (StepNode) super.getStepNode(step);
	}
	
	@Override
	public StepNode makeStepNode(Step step){
		return (StepNode) super.makeStepNode(step);
	}
	
	@Override
	protected StepNode constructStepNode(Step step){
		if(step instanceof IntentionalStep)
			return new StepNode(this, (IntentionalStep) step);
		else
			throw new IllegalArgumentException("Step nodes must be constructed from intentional steps.");
	}
	
	@Override
	public GoalNode getGoalNode(Expression goal){
		return (GoalNode) super.getGoalNode(goal);
	}
	
	@Override
	public GoalNode makeGoalNode(Expression expression){
		return (GoalNode) super.makeGoalNode(expression);
	}
	
	@Override
	protected GoalNode constructGoalNode(Expression goal){
		return new GoalNode(this, goal);
	}
}