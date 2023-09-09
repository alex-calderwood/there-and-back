package com.stephengware.java.planware.ff;

import com.stephengware.java.planware.search.Heuristic;

public class FastForwardHeuristic implements Heuristic<FastForwardSearchNode> {
	
	@Override
	public double getValue(FastForwardSearchNode node){
		return node.relaxedPlan.size();
	}
}
