package com.stephengware.java.glaive;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.search.Strategy;

public class DefaultGlaiveSearch extends GlaiveSearch<GlaiveSearchNode> {

	public DefaultGlaiveSearch(Strategy<GlaiveSearchNode> strategy, GlaiveRelaxedPlanBuilder relaxedPlanner, Expression goal){
		super(strategy, relaxedPlanner, goal);
	}

	@Override
	protected GlaiveSearchNode makeSuccessor(GlaiveSearchNode parent, IntentionalStep next){
		return new GlaiveSearchNode(parent, next);
	}
}
