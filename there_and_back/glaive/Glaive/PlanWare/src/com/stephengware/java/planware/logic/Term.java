package com.stephengware.java.planware.logic;

public interface Term extends Entity {

	public String getName();
	
	public Type getType();
		
	@Override
	public Term substitute(Substitution substitution);
}
