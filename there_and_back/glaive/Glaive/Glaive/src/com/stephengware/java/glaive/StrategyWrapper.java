package com.stephengware.java.glaive;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;

import com.stephengware.java.planware.search.NodeSearch;
import com.stephengware.java.planware.search.Strategy;

public class StrategyWrapper<N extends GlaiveSearchNode> implements Strategy<N> {

	private final Strategy<N> strategy;
	final Queue<N> solutions = new LinkedList<>();
	private final HashSet<N> foundSolutions = new HashSet<>();
	
	public StrategyWrapper(Strategy<N> strategy){
		this.strategy = strategy;
	}

	@Override
	public N next(NodeSearch<N> search){
		if(solutions.isEmpty()){
			N node = strategy.next(search);
			while(foundSolutions.contains(node))
				node = strategy.next(search);
			return node;
		}
		else{
			N node = solutions.poll();
			foundSolutions.add(node);
			return node;
		}
	}

	@Override
	public int expand(NodeSearch<N> search, N node){
		return strategy.expand(search, node);
	}

	@Override
	public N getBestNode(){
		return strategy.getBestNode();
	}
}
