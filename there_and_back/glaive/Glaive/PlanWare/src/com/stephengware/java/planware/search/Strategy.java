package com.stephengware.java.planware.search;

public interface Strategy<N extends Node> {

	public N next(NodeSearch<N> search);
	
	public int expand(NodeSearch<N> search, N node);
	
	public N getBestNode();
}
