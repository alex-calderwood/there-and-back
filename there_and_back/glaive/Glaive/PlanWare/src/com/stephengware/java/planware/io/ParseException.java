package com.stephengware.java.planware.io;

public class ParseException extends Exception {

	private static final long serialVersionUID = 1L;
	public final Object document;
	public final String message;
	int lineNumber;
	int characterNumber;

	public ParseException(Object document, String message, int lineNumber, int characterNumber){
		this.document = document;
		this.message = message;
		this.lineNumber = lineNumber;
		this.characterNumber = characterNumber;
	}
	
	public ParseException(Object document, String message){
		this(document, message, 0, 0);
	}
	
	public ParseException(String message){
		this(null, message, 0, 0);
	}
	
	public ParseException(Object document, Class<?> objectType){
		this(document, "The document \"" + document + "\" could not be parsed as " + objectType.getSimpleName() + ".", 0, 0);
	}
	
	private static final String ADDITION = " (at";
	
	@Override
	public String getMessage(){
		String message = this.message;
		String ending = ".";
		if(message.endsWith(".") || message.endsWith("!")){
			ending = message.substring(message.length() - 1);
			message = message.substring(0, message.length() - 1);
		}
		String addition = ADDITION;
		if(lineNumber > 0)
			addition += " line " + lineNumber;
		if(characterNumber > 0)
			addition += " character " + characterNumber;
		if(addition != ADDITION)
			message = message + addition + ")";
		return message + ending;
	}
}
