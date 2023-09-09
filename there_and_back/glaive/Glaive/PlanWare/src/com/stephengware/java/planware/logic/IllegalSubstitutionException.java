package com.stephengware.java.planware.logic;

public class IllegalSubstitutionException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public IllegalSubstitutionException(Entity original, Entity substitution, Class<? extends Entity> entityType){
		super("The " + substitution.getDescription() + " \"" + substitution + "\" was substituted for the " + original.getDescription() + " \"" + original + "\", but a " + entityType.getSimpleName() + " was expected.");
	}
}
