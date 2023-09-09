package com.stephengware.java.planware.graph;

import java.util.Iterator;

import com.stephengware.java.planware.logic.Expression;

public class GoalNode extends SatisfiableNode {

	public final Expression expression;
	
	protected GoalNode(ProblemGraph graph, Expression expression){
		super(graph);
		this.expression = expression;
	}
	
	@Override
	public void satisfy(){
		super.satisfy();
		activate();
	}
	
	@Override
	public Iterator<PreconditionNode> parents(){
		return parents.iterator();
	}
	
	@Override
	public String toString(){
		return "[Goal Node: " + expression + "]";
	}
}
