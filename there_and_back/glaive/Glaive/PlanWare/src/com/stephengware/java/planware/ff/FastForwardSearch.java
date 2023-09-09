package com.stephengware.java.planware.ff;

import com.stephengware.java.planware.ListPlan;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.search.NodeSearch;
import com.stephengware.java.planware.search.Strategy;

public class FastForwardSearch extends NodeSearch<FastForwardSearchNode> {

	protected final Strategy<FastForwardSearchNode> strategy;
	protected final FastForwardRelaxedPlanBuilder relaxedPlanBuilder;
	protected final Expression goal;
	
	public FastForwardSearch(Strategy<FastForwardSearchNode> strategy, FastForwardRelaxedPlanBuilder relaxedPlanBuilder, Expression goal){
		super(strategy);
		this.strategy = strategy;
		this.relaxedPlanBuilder = relaxedPlanBuilder;
		this.goal = goal;
	}

	@Override
	protected boolean hasNextSuccessor(FastForwardSearchNode node){
		return node.hasNextSuccessor();
	}

	@Override
	protected FastForwardSearchNode getNextSuccessor(FastForwardSearchNode node){
		Step next = node.getNextSuccessor();
		ListPlan plan = node.getPlan().clone();
		plan.addStep(next);
		State state = node.getState().clone();
		state.execute(next);
		FastForwardSearchNode successor = new FastForwardSearchNode(plan, state);
		relaxedPlanBuilder.evaluate(successor);
		return successor;
	}

	@Override
	protected boolean isSolution(FastForwardSearchNode node){
		return node.getState().isTrue(goal);
	}
}
