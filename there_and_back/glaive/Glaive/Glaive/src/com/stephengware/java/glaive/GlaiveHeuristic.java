package com.stephengware.java.glaive;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.search.Heuristic;

public class GlaiveHeuristic<N extends GlaiveSearchNode> implements Heuristic<N> {
	
	@Override
	public double getValue(N node){
		if(!node.isAuthorGoalAchievable() && !node.isCharacterGoalAchievable())
			return Heuristic.INFINITE;
		else{
			double distance = Math.max(node.getRelaxedPlan().size(), node.tokens.countDistances()) + node.remaining.length;
			if(node.remaining.length != 0)
				for(IntentionalStep step : node.getRelaxedPlan())
					if(node.remaining.contains(step))
						distance--;
			return distance;
		}
	}
}
