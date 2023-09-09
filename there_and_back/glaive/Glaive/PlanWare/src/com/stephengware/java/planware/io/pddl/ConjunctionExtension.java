package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.logic.Conjunction;
import com.stephengware.java.planware.logic.Expression;

public class ConjunctionExtension extends BooleanExpressionExtension<Conjunction, Expression> {

	public static final String CONJUNCTION_OPERATOR = "and";
	
	public ConjunctionExtension(){
		super(Conjunction.class, CONJUNCTION_OPERATOR, Expression.class, 2, -1);
	}

	@Override
	protected Conjunction construct(Expression[] arguments){
		return new Conjunction(arguments);
	}
}
