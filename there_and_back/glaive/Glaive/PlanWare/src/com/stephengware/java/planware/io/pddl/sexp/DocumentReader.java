package com.stephengware.java.planware.io.pddl.sexp;

import java.io.IOException;
import java.io.Reader;
import java.util.LinkedList;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.ParseException;

public class DocumentReader implements com.stephengware.java.planware.io.DocumentReader<SExpression> {
	
	public static final com.stephengware.java.planware.io.DocumentReader<SExpression> DOCUMENT_READER = new DocumentReader();
	
	@Override
	public SExpression read(Reader reader) throws IOException, ParseException {
		Tokenizer tokens = new Tokenizer(reader);
		tokens.nextToken();
		LinkedList<Node> children = new LinkedList<>();
		Node child = parseDocument(tokens);
		while(child != null){
			children.add(child);
			child = parseDocument(tokens);
		}
		Root root = null;
		try{ root = new Root(children); }
		catch(BuildException ex){/* will not occur */}
		if(root.getLength() == 1)
			return root.getChild(0);
		else
			return root;
	}
	
	private final Node parseDocument(Tokenizer tokens) throws IOException, ParseException {
		if(tokens.token == null)
			return null;
		else if(tokens.token == Tokenizer.END_LIST)
			throw new ParseException(null, "Expected end of document, but encountered end of list.", tokens.lineNumber, 0);
		else if(tokens.token == Tokenizer.START_LIST){
			int lineNumber = tokens.lineNumber;
			LinkedList<Node> children = new LinkedList<Node>();
			tokens.nextToken();
			while(tokens.token != Tokenizer.END_LIST){
				if(tokens.token == null)
					throw new ParseException(null, "Expected end of list, but encountered end of document.", tokens.lineNumber, -1);
				children.add(parseDocument(tokens));
			}
			tokens.nextToken();
			List list = null;
			try{ list = new List(children, lineNumber); }
			catch(BuildException ex){/* will not occur */}
			return list;
		}
		else{
			String content = tokens.token;
			int lineNumber = tokens.lineNumber;
			tokens.nextToken();
			Symbol symbol = null;
			try{ symbol = new Symbol(content, lineNumber); }
			catch(BuildException ex){/* will not occur */}
			return symbol;
		}
	}

	@Override
	public int getLineNumber(SExpression document){
		return document.getLineNumber();
	}

	@Override
	public int getCharacterNumber(SExpression document){
		return -1;
	}
}
