package com.stephengware.java.planware.search;

import com.stephengware.java.planware.ArgumentMap;
import com.stephengware.java.planware.Planner;
import com.stephengware.java.planware.Search;

public abstract class NodeSearch<N extends Node> extends Search {

	protected final Strategy<N> strategy;
	
	public NodeSearch(Strategy<N> strategy){
		this.strategy = strategy;
	}
	
	private Result result = null;
	
	@Override
	public synchronized final Result getNextPlan(ArgumentMap arguments){
		result = new Result();
		long startTime = System.currentTimeMillis();
		int timeLimit = arguments.get(Planner.TIME_LIMIT);
		long endTime;
		if(timeLimit == -1)
			endTime = -1;
		else
			endTime = startTime + timeLimit;
		int searchLimit = arguments.get(Planner.SEARCH_LIMIT);
		N bestNode = null;
		try{
			while(!isDone(endTime, searchLimit)){
				N current = pop();
				if(current == null)
					break;
				push(current);
				if(isSolution(current)){
					bestNode = current;
					break;
				}
			}
		}
		catch(OutOfMemoryError ex){
			/* do nothing */
		}
		if(bestNode == null)
			bestNode = strategy.getBestNode();
		if(bestNode == null){
			result.plan = null;
			result.success = false;
		}
		else{
			result.plan = bestNode.getPlan();
			result.success = isSolution(bestNode);
		}
		result.time = System.currentTimeMillis() - startTime;
		return result;
	}
	
	private final boolean isDone(long endTime, int searchLimit){
		if(endTime != -1 && System.currentTimeMillis() >= endTime)
			return true;
		if(searchLimit != -1 && result.visited >= searchLimit)
			return true;
		return false;
	}
	
	protected final N pop(){
		N node = strategy.next(this);
		if(node == null)
			return null;
		if(!node.visited){
			result.visited++;
			node.visited = true;
		}
		return node;
	}
	
	protected final void push(N node){
		result.generated += strategy.expand(this, node);
	}
	
	protected abstract boolean hasNextSuccessor(N node);
	
	protected abstract N getNextSuccessor(N node);
	
	protected abstract boolean isSolution(N node);
}
