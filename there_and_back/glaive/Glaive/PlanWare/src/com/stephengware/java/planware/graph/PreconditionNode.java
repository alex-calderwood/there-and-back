package com.stephengware.java.planware.graph;

import java.util.Iterator;

import com.stephengware.java.planware.logic.Expression;

public class PreconditionNode extends Node {

	public final Expression clause;
	public final NodeList<LiteralNode> parents = new NodeList<>();
	public final SatisfiableNode child;
	private int parentCount = 0;
	
	protected PreconditionNode(ProblemGraph graph, Expression clause, SatisfiableNode child){
		super(graph);
		this.clause = clause;
		this.child = child;
	}
	
	final void incrementParentCount(){
		if(parentCount == 0)
			addToResetList();
		parentCount++;
		if(parentCount == parents.size())
			activate();
	}
	
	@Override
	public boolean activate(){
		if(super.activate()){
			child.incrementPreconditionCount();
			return true;
		}
		return false;
	}
	
	final void decrementParentCount(){
		parentCount--;
		if(parentCount == parents.size() - 1)
			deactivate();
	}

	@Override
	public boolean deactivate(){
		if(super.deactivate()){
			child.decrementPreconditionCount();
			return true;
		}
		return false;
	}
	
	@Override
	public void reset(){
		super.reset();
		this.parentCount = 0;
	}
	
	@Override
	public Iterator<LiteralNode> parents(){
		return parents.iterator();
	}
	
	@Override
	public String toString(){
		return "[Precondition Node: " + clause + "]";
	}
	
	@Override
	public String describe(){
		String str = super.describe();
		for(LiteralNode parent : parents)
			str += "\n  " + parent.describe();
		return str;
	}
}
