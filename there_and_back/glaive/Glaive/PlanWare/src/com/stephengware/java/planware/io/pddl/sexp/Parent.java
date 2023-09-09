package com.stephengware.java.planware.io.pddl.sexp;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.ParseException;

public interface Parent extends SExpression, Iterable<Node> {
	
	public static final int ANY_LENGTH = -1;

	public int getLength();
	
	public Node getChild(int index) throws ParseException;
	
	public int indexOf(Node child);
	
	public int indexOf(String symbol);
	
	public void addChild(SExpression child) throws BuildException;
	
	public void addChild(String symbol) throws BuildException;
	
	public void addChild(int index, SExpression child) throws BuildException;
	
	public void addChild(int index, String symbol) throws BuildException;
	
	public void removeChild(Node child) throws BuildException;
	
	public void removeChild(String symbol) throws BuildException;
	
	public void removeChild(int index) throws BuildException;
	
	public void replaceChild(Node toReplace, Node replacement) throws BuildException;
	
	public void replaceChild(String toReplace, String replacement) throws BuildException;
	
	public void replaceChild(int index, Node replacement) throws BuildException;
	
	public void replaceChild(int index, String replacement) throws BuildException;
	
	public Symbol findSymbol(String symbol);
	
	public Symbol requireSymbol(String symbol) throws ParseException;
	
	public List findListStartingWith(String symbol);
	
	public List requireListStartingWith(String symbol) throws ParseException;
	
	public java.util.List<List> findListsStartingWith(String symbol);
	
	public java.util.List<List> requireListsStartingWith(String symbol) throws ParseException;
	
	public FormatRule getFormatRule();
	
	public void setFormatRule(FormatRule formatRule);
}
