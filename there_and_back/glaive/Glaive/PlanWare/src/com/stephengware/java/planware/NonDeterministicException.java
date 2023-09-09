package com.stephengware.java.planware;

import com.stephengware.java.planware.logic.Expression;

public class NonDeterministicException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public NonDeterministicException(Expression expression){
		super("The " + expression.getDescription() + " \"" + expression + "\" is non-deterministic.");
	}
}
