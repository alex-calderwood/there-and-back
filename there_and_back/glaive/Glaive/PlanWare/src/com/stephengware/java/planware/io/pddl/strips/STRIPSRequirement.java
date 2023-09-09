package com.stephengware.java.planware.io.pddl.strips;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public class STRIPSRequirement extends Requirement {

	private static final Extension<SExpression, SExpression> OPERATOR_EXTENSION = new OperatorExtension();
	private static final Extension<SExpression, SExpression> DOMAIN_OPERATORS_EXTENSION = new DomainOperatorsExtension();
	
	public static final Requirement STRIPS = new STRIPSRequirement();
	
	private STRIPSRequirement(){
		super("strips", "STRIPS-style actions", OPERATOR_EXTENSION, DOMAIN_OPERATORS_EXTENSION);
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		return domain.operators.length > 0;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return false;
	}
}
