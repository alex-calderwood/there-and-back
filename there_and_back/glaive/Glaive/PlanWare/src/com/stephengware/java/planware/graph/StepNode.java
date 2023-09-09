package com.stephengware.java.planware.graph;

import com.stephengware.java.planware.Step;

public class StepNode extends ChangeNode {

	public final Step step;
	
	protected StepNode(ProblemGraph graph, Step step){
		super(graph);
		this.step = step;
	}
	
	@Override
	public String toString(){
		return "[Step Node: " + step + "]";
	}
}
