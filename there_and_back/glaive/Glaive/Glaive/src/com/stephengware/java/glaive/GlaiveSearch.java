package com.stephengware.java.glaive;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.search.NodeSearch;
import com.stephengware.java.planware.search.Strategy;

public abstract class GlaiveSearch<N extends GlaiveSearchNode> extends NodeSearch<N> {

	protected final StrategyWrapper<N> strategy;
	protected final GlaiveRelaxedPlanBuilder relaxedPlanner;
	protected final Expression goal;
	
	public GlaiveSearch(Strategy<N> strategy, GlaiveRelaxedPlanBuilder relaxedPlanner, Expression goal){
		super(new StrategyWrapper<N>(strategy));
		this.strategy = (StrategyWrapper<N>) super.strategy;
		this.relaxedPlanner = relaxedPlanner;
		this.goal = goal;
	}

	@Override
	protected boolean hasNextSuccessor(N node){
		return node.hasNextStep();
	}

	@Override
	protected N getNextSuccessor(N node){
		IntentionalStep next = node.getNextStep();
		N child = makeSuccessor(node, next);
		relaxedPlanner.evaluate(child);
		node.children.add(child);
		checkForSolutions(node, child);
		return child;
	}
	
	@SuppressWarnings("unchecked")
	private final void checkForSolutions(N parent, N node){
		node.unexplainedCount = parent.unexplainedCount + node.plan.getLastStep().source.agents.length == 0 ? 0 : 1;
		int count = node.getPlan().countUnexplainedSteps();
		while(node != null && count < node.unexplainedCount){
			node = parent;
			parent = (N) parent.parent;
			count = node.getPlan().countUnexplainedSteps();
		}
		checkTreeForSolutions(node);
	}
	
	@SuppressWarnings("unchecked")
	private final void checkTreeForSolutions(N node){
		int count = node.getPlan().countUnexplainedSteps();
		if(node.unexplainedCount == count)
			return;
		node.unexplainedCount = count;
		if(isSolution(node))
			strategy.solutions.add(node);
		for(int i=0; i<node.children.size(); i++)
			checkTreeForSolutions((N) node.children.get(i));
	}
	
	protected abstract N makeSuccessor(N parent, IntentionalStep next);

	@Override
	protected boolean isSolution(N node){
		return node.getState().isTrue(goal) && node.remaining.length == 0 && node.getPlan().countUnexplainedSteps() == 0;
	}
}
