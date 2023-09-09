package com.stephengware.java.planware.logic;

public interface Bindings extends Substitution {
	
	public Term getValue(TermVariable variable);
	
	public boolean areEqual(TermVariable variable, Term term);
	
	public boolean areNotEqual(TermVariable variable, Term term);
	
	public Expression getValue(ExpressionVariable variable);
	
	public boolean areEqual(ExpressionVariable variable, Expression expression);
	
	public boolean areNotEqual(ExpressionVariable variable, Expression expression);
}
