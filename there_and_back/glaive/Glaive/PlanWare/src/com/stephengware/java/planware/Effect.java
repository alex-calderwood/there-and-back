package com.stephengware.java.planware;

import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.util.ImmutableArray;

public class Effect {

	public final Expression expression;
	public final ImmutableArray<Clause> conditions;
	public final Literal literal;
	
	protected Effect(Expression expression, Expression condition, Literal literal){
		this.expression = expression;
		this.conditions = new ImmutableArray<>(Utilities.getPreconditionClauses("effect", condition));
		this.literal = literal;
	}
}
