package com.stephengware.java.planware.search;

public interface Heuristic<N extends Node> {

	public static final double INFINITE = Double.MAX_VALUE;
	
	public double getValue(N node);
}
