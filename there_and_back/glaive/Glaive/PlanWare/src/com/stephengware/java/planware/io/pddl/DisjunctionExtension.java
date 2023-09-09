package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.logic.Disjunction;
import com.stephengware.java.planware.logic.Expression;

public class DisjunctionExtension extends BooleanExpressionExtension<Disjunction, Expression> {

	public static final String DISJUNCTION_OPERATOR = "or";
	
	public DisjunctionExtension(){
		super(Disjunction.class, DISJUNCTION_OPERATOR, Expression.class, 2, -1);
	}

	@Override
	protected Disjunction construct(Expression[] arguments){
		return new Disjunction(arguments);
	}
}
