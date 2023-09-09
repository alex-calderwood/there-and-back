package com.stephengware.java.planware;

public class FormatException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	public FormatException(String objectType, String reason){
		super("Illegal format for " + objectType + ": "  + reason);
	}

}
