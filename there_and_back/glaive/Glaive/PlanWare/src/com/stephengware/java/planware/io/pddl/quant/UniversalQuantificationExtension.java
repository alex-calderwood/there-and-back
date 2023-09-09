package com.stephengware.java.planware.io.pddl.quant;

import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.UniversalQuantification;

public class UniversalQuantificationExtension extends QuantifiedExpressionExtension<UniversalQuantification> {

	public static final String UNIVERSAL_QUANTIFIER = "forall";
	
	public UniversalQuantificationExtension(){
		super(UniversalQuantification.class, UNIVERSAL_QUANTIFIER);
	}
	
	@Override
	protected UniversalQuantification construct(TermVariable variable, Expression argument){
		return new UniversalQuantification(variable, argument);
	}
}
