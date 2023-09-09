package com.stephengware.java.glaive;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.search.Heuristic;

public class FastForwardHeuristic<N extends GlaiveSearchNode> implements Heuristic<N> {
	
	@Override
	public double getValue(N node){
		double distance = node.getRelaxedPlan().size() + node.remaining.length;
		if(node.remaining.length != 0)
			for(IntentionalStep step : node.getRelaxedPlan())
				if(node.remaining.contains(step))
					distance--;
		return distance;
	}
}
