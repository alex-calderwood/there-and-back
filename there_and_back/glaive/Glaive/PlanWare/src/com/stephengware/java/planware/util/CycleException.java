package com.stephengware.java.planware.util;

public class CycleException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public CycleException(Object tail, Object head){
		super("Adding an edge from \"" + tail + "\" to \"" + head + "\" would create a cycle.");
	}
}
