package com.stephengware.java.planware.io.pddl.quant;

import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.RequirementGroup;

public class QuantifiedPreconditionsRequirement extends RequirementGroup {

	public static final Requirement QUANTIFIED_PRECONDITIONS = new QuantifiedPreconditionsRequirement();
	
	private QuantifiedPreconditionsRequirement(){
		super("quantified-preconditions", "universally and existentially quantified preconditions and goals",
				UniversalPreconditionsRequirement.UNIVERSAL_PRECONDITIONS,
				ExistentialPreconditionsRequirement.EXISTENTIAL_PRECONDITIONS);
	}
}
