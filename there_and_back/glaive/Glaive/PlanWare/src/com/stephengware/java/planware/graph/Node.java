package com.stephengware.java.planware.graph;

import java.util.Iterator;

public abstract class Node {

	protected final ProblemGraph graph;
	Node previousReset = null;
	Node nextReset = null;
	private boolean active = false;
	
	protected Node(ProblemGraph graph){
		this.graph = graph;
	}
	
	public final boolean isActive(){
		return active;
	}
	
	public boolean activate(){
		if(!active){
			active = true;
			addToResetList();
			return true;
		}
		return false;
	}
	
	public boolean deactivate(){
		if(isActive()){
			active = false;
			removeFromResetList();
			return true;
		}
		return false;
	}
	
	public void reset(){
		this.active = false;
		removeFromResetList();
	}
	
	protected final void addToResetList(){
		if(previousReset != null || nextReset != null)
			return;
		if(graph.firstReset != null){
			graph.firstReset.previousReset = this;
			nextReset = graph.firstReset;
		}
		graph.firstReset = this;
	}
	
	private final void removeFromResetList(){
		if(graph.firstReset == this)
			graph.firstReset = nextReset;
		else{
			previousReset.nextReset = nextReset;
			if(nextReset != null)
				nextReset.previousReset = previousReset;
		}
		previousReset = null;
		nextReset = null;
	}
	
	public abstract Iterator<? extends Node> parents();
	
	public String describe(){
		if(isActive())
			return toString() + " (active)";
		else
			return toString() + " (inactive)";
	}
}
