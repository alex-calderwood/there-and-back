package com.stephengware.java.planware.io.pddl.adl;

import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.RequirementGroup;

public class ADLRequirement extends RequirementGroup {

	public static final Requirement ADL = new ADLRequirement();
	
	private ADLRequirement(){
		super("adl", "features of the Action Description Language",
				com.stephengware.java.planware.io.pddl.strips.STRIPSRequirement.STRIPS,
				com.stephengware.java.planware.io.pddl.negp.NegativePreconditionsRequirement.NEGATIVE_PRECONDITIONS,
				com.stephengware.java.planware.io.pddl.types.TypingRequirement.TYPING,
				com.stephengware.java.planware.io.pddl.eq.EqualityRequirement.EQUALITY,
				com.stephengware.java.planware.io.pddl.disjp.DisjunctivePreconditionsRequirement.DISJUNCTIVE_PRECONDITIONS,
				com.stephengware.java.planware.io.pddl.quant.QuantifiedPreconditionsRequirement.QUANTIFIED_PRECONDITIONS,
				com.stephengware.java.planware.io.pddl.quant.UniversalEffectsRequirement.UNIVERSAL_EFFECTS,
				com.stephengware.java.planware.io.pddl.cond.ConditionalEffectsRequirement.CONDITIONAL_EFFECTS);
	}
}
