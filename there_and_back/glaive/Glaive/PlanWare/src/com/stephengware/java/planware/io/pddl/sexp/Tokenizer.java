package com.stephengware.java.planware.io.pddl.sexp;

import java.io.IOException;
import java.io.Reader;
import java.io.StreamTokenizer;

class Tokenizer {

	static final String START_LIST = "(";
	static final String END_LIST = ")";
	
	private static final int START = '(';
	private static final int END = ')';
	private static final int STRING = '"';
	
	String token = null;
	int lineNumber = 0;
	
	private final StreamTokenizer streamTokenizer;
		
	Tokenizer(Reader reader){
		this.streamTokenizer = new StreamTokenizer(reader);
		streamTokenizer.resetSyntax();
		streamTokenizer.whitespaceChars(0, ' ');
		streamTokenizer.wordChars(' ' + 1,255);
		streamTokenizer.eolIsSignificant(false);
		streamTokenizer.ordinaryChar('(');
		streamTokenizer.ordinaryChar(')');
		streamTokenizer.commentChar(';');
		streamTokenizer.quoteChar(STRING);
	}
	
	boolean hasNextToken(){
		return token != null || lineNumber == 0;
	}
	
	void nextToken() throws IOException {
		streamTokenizer.nextToken();
		lineNumber = streamTokenizer.lineno();
		switch(streamTokenizer.ttype){
		case StreamTokenizer.TT_EOF:
			token = null; break;
		case START:
			token = START_LIST; break;
		case END:
			token = END_LIST; break;
		default:
			token = streamTokenizer.sval; break;
		}
	}
}