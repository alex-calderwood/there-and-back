package com.stephengware.java.planware.io.pddl.quant;

import com.stephengware.java.planware.logic.ExistentialQuantification;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.TermVariable;

public class ExistentialQuantificationExtension extends QuantifiedExpressionExtension<ExistentialQuantification> {

	public static final String EXISTENTIAL_QUANTIFIER = "exists";
	
	public ExistentialQuantificationExtension(){
		super(ExistentialQuantification.class, EXISTENTIAL_QUANTIFIER);
	}

	@Override
	protected ExistentialQuantification construct(TermVariable variable, Expression argument){
		return new ExistentialQuantification(variable, argument);
	}
}
