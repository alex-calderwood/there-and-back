package com.stephengware.java.planware.graph;

public abstract class SatisfiableNode extends Node {

	public final NodeList<PreconditionNode> parents = new NodeList<>();
	private int preconditionCount = 0;
	
	protected SatisfiableNode(ProblemGraph graph){
		super(graph);
	}
	
	public boolean isSatisfied(){
		return parents.size() == 0 || preconditionCount > 0;
	}
	
	final void incrementPreconditionCount(){
		if(preconditionCount == 0)
			addToResetList();
		preconditionCount++;
		if(preconditionCount == 1)
			satisfy();
	}
	
	public void satisfy(){
		addToResetList();
	}
	
	final void decrementPreconditionCount(){
		preconditionCount--;
		if(preconditionCount == 0)
			dissatisfy();
	}
	
	public void dissatisfy(){}

	@Override
	public boolean activate(){
		if(!isSatisfied())
			throw new IllegalStateException(this + " cannot be activated until its precondition is satisfied.");
		return super.activate();
	}
	
	@Override
	public void reset(){
		super.reset();
		preconditionCount = 0;
	}
	
	@Override
	public String describe(){
		String str = super.describe();
		for(PreconditionNode parent : parents)
			str += "\n  " + parent.describe().replaceAll("\n  ", "\n    ");
		return str;
	}
}
