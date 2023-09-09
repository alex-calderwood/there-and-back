package com.stephengware.java.planware.logic;

public abstract class BindingsObject extends SubstitutionObject implements Bindings {

	@Override
	protected Entity substitute(Entity entity){
		if(entity instanceof TermVariable)
			return getValue((TermVariable) entity);
		else if(entity instanceof ExpressionVariable)
			return getValue((ExpressionVariable) entity);
		return entity;
	}

	@Override
	public boolean areEqual(TermVariable variable, Term term){
		if(term instanceof TermVariable)
			return getValue(variable).equals(getValue((TermVariable) term));
		else
			return getValue(variable).equals(term);
	}

	@Override
	public boolean areNotEqual(TermVariable variable, Term term){
		return !areEqual(variable, term);
	}

	@Override
	public boolean areEqual(ExpressionVariable variable, Expression expression){
		if(expression instanceof ExpressionVariable)
			return getValue(variable).equals(getValue((ExpressionVariable) expression));
		else
			return getValue(variable).equals(expression);
	}

	@Override
	public boolean areNotEqual(ExpressionVariable variable,	Expression expression){
		return !areEqual(variable, expression);
	}
}
