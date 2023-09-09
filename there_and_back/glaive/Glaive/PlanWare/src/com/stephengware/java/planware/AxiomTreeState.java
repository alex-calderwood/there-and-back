package com.stephengware.java.planware;

import java.util.Iterator;

public abstract class AxiomTreeState extends State {

	protected final AxiomTree axiomTree;
	
	protected AxiomTreeState(AxiomTree axiomTree){
		this.axiomTree = axiomTree;
	}
	
	protected void update(){
		applyAxioms();
	}
	
	protected void applyAxioms(){
		boolean changed = true;
		while(changed){
			changed = false;
			for(Iterator<Axiom> iterator = axiomTree.getApplicableAxioms(this); iterator.hasNext();)
				if(applyAxiom(iterator.next()))
					changed = true;
		}
	}
	
	protected boolean applyAxiom(Axiom axiom){
		return axiom.implies.impose(this);
	}
}
