package com.stephengware.java.glaive;

import java.util.Comparator;

public class GlaiveTieBreaker<N extends GlaiveSearchNode> implements Comparator<N> {

	@Override
	public int compare(N node1, N node2){
		int n1score = 0;
		if(node1.isAuthorGoalAchievable())
			n1score++;
		if(node1.isCharacterGoalAchievable())
			n1score++;
		int n2score = 0;
		if(node2.isAuthorGoalAchievable())
			n2score++;
		if(node2.isCharacterGoalAchievable())
			n2score++;
		int difference = n2score - n1score;
		if(difference == 0)
			difference = node1.tokens.countDistances() - node2.tokens.countDistances();
		return difference;
	}
}
