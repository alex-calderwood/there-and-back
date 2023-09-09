package com.stephengware.java.glaive;

import com.stephengware.java.planware.Axiom;

public class AxiomEvent extends Event {

	public final Axiom source;
	
	protected AxiomEvent(Axiom axiom, int time, CausalState state){
		super(axiom, time, axiom.getPreconditionClauses(), axiom.getEffectLiterals(), state);
		this.source = axiom;
	}
}
