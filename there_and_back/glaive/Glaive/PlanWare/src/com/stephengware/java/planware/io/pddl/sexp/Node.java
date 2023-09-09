package com.stephengware.java.planware.io.pddl.sexp;

import com.stephengware.java.planware.io.ParseException;

public abstract class Node implements SExpression {
	
	static final int NO_LINE_NUMBER = 0;
	
	private int lineNumber;
	Parent parent;
	Node next;
	Node previous;
	
	Node(int lineNumber){
		this.lineNumber = lineNumber;
	}
	
	public int getLineNumber(){
		return lineNumber;
	}
	
	public Parent getParent(){
		return parent;
	}
	
	public Node getNextSibling(){
		return next;
	}
	
	public Node requireNextSibling() throws ParseException {
		if(next == null)
			throw new ParseException("Expected something after \"" + toString() + "\".");
		return next;
	}
	
	public Node getPreviousSibling(){
		return previous;
	}
	
	public Node requirePreviousSibling() throws ParseException {
		if(next == null)
			throw new ParseException("Expected something before \"" + toString() + "\".");
		return next;
	}
}
