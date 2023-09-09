package com.stephengware.java.planware.graph;

import com.stephengware.java.planware.Axiom;

public class AxiomNode extends ChangeNode {

	public final Axiom axiom;
	
	protected AxiomNode(ProblemGraph graph, Axiom axiom){
		super(graph);
		this.axiom = axiom;
	}
	
	@Override
	public void satisfy(){
		super.satisfy();
		activate();
	}
	
	@Override
	public String toString(){
		return "[Axiom Node: " + axiom + "]";
	}
}
