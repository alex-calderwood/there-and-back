package com.stephengware.java.planware.search;

import java.util.Comparator;

public class DeferredEvaluationHeuristicSearch<N extends Node> extends HeuristicSearch<N> {

	public DeferredEvaluationHeuristicSearch(Heuristic<? super N> heuristic, Comparator<? super N> tieBreaker, N root, boolean debug){
		super(heuristic, tieBreaker, root, debug);
	}
	
	public DeferredEvaluationHeuristicSearch(Heuristic<? super N> heuristic, N root, boolean debug){
		super(heuristic, root, debug);
	}
	
	@Override
	public N next(NodeSearch<N> search){
		HeuristicNode hnode = peek();
		if(hnode == null)
			return null;
		else
			return hnode.node;
	}
	
	@Override
	public int expand(NodeSearch<N> search, N node){
		int generated = 0;
		if(search.hasNextSuccessor(node)){
			push(search.getNextSuccessor(node));
			generated++;
		}
		HeuristicNode hnode = peek();
		while(hnode != null && hnode.node == node){
			if(!search.hasNextSuccessor(node)){
				pop();
				break;
			}
			push(search.getNextSuccessor(node));
			generated++;
			hnode = peek();
		}
		return generated;
	}
}
