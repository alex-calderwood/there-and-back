package com.stephengware.java.planware.io.pddl.sexp;

import java.io.IOException;
import java.io.Writer;

import com.stephengware.java.planware.io.ParseException;

public interface SExpression {
	
	public int getLineNumber();
	
	public boolean isSymbol();
	
	public boolean isSymbol(String content);
	
	public boolean isList();
	
	public boolean isList(int length);
	
	public boolean isList(int minLength, int maxLength);
	
	public boolean isRoot();
	
	public boolean isRoot(int length);
	
	public boolean isRoot(int minLength, int maxLength);
	
	public boolean isParent();
	
	public boolean isParent(int length);
	
	public boolean isParent(int minLength, int maxLength);
	
	public boolean isNode();
	
	public Symbol asSymbol() throws ParseException;
	
	public Symbol asSymbol(String content) throws ParseException;
	
	public List asList() throws ParseException;
	
	public List asList(int length) throws ParseException;
	
	public List asList(int minLength, int maxLength) throws ParseException;
	
	public Root asRoot() throws ParseException;
	
	public Root asRoot(int length) throws ParseException;
	
	public Root asRoot(int minLength, int maxLength) throws ParseException;
	
	public Parent asParent() throws ParseException;
	
	public Parent asParent(int length) throws ParseException;
	
	public Parent asParent(int minLength, int maxLength) throws ParseException;
	
	public Node asNode() throws ParseException;
	
	public void write(Writer writer) throws IOException;
}
