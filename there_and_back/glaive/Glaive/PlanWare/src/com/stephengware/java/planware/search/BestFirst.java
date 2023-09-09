package com.stephengware.java.planware.search;

public class BestFirst<N extends Node> implements Heuristic<N> {

	private final Heuristic<N> heuristic;
	
	public BestFirst(Heuristic<N> heuristic){
		this.heuristic = heuristic;
	}

	@Override
	public double getValue(N node){
		return node.getPlan().countSteps() + heuristic.getValue(node);
	}
}
