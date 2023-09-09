package com.stephengware.java.planware.logic;

import com.stephengware.java.planware.State;

public interface Expression extends Entity {
		
	public static final TrueExpression TRUE = new TrueExpression();
	public static final FalseExpression FALSE = new FalseExpression();

	@Override
	public Expression substitute(Substitution substitution);
	
	public boolean isTestable();
	
	public boolean test(State state);
	
	public boolean isImposable();
	
	public boolean impose(State state);
	
	public Expression negate();
	
	public Expression toCNF();
	
	public Expression toDNF();
}
