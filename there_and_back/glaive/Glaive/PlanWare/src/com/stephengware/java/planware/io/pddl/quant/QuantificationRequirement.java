package com.stephengware.java.planware.io.pddl.quant;

import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public abstract class QuantificationRequirement extends Requirement {

	private static final Extension<SExpression, SExpression> UNIVERSAL_QUANTIFICATION_EXTENSION = new UniversalQuantificationExtension();
	private static final Extension<SExpression, SExpression> EXISTENTIAL_QUANTIFICATION_EXTENSION = new ExistentialQuantificationExtension();
	
	protected QuantificationRequirement(String name, String description) {
		super(name, description, UNIVERSAL_QUANTIFICATION_EXTENSION, EXISTENTIAL_QUANTIFICATION_EXTENSION);
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}
}
