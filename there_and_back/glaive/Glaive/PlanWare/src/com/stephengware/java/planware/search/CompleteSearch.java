package com.stephengware.java.planware.search;

public abstract class CompleteSearch<N extends Node> implements Strategy<N> {

	@Override
	public final N next(NodeSearch<N> search){
		return pop();
	}
	
	protected abstract N pop();
	
	@Override
	public final int expand(NodeSearch<N> search, N node){
		int generated = 0;
		while(search.hasNextSuccessor(node)){
			push(search.getNextSuccessor(node));
			generated++;
		}
		return generated;
	}
	
	protected abstract void push(N node);
}
