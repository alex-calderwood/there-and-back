package com.stephengware.java.planware.io.pddl.sexp;

import java.io.IOException;
import java.io.Writer;
import java.util.Iterator;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.ParseException;

public class Root implements Parent {
	
	private final NodeList children;
	private FormatRule formatRule = FormatRule.DEFAULT;
	
	public Root(java.util.List<Node> children) throws BuildException {
		this.children = new NodeList(this, children);
	}
	
	public Root(Node...nodes) throws BuildException {
		this(List.nodesToList(nodes));
	}
	
	public Root(Object...objects) throws BuildException {
		this(List.objectsToList(objects));
	}

	@Override
	public int getLineNumber(){
		return 1;
	}
	
	@Override
	public boolean isSymbol(){
		return false;
	}

	@Override
	public boolean isSymbol(String content){
		return false;
	}

	@Override
	public boolean isList(){
		return false;
	}

	@Override
	public boolean isList(int length){
		return false;
	}

	@Override
	public boolean isList(int minLength, int maxLength){
		return false;
	}

	@Override
	public boolean isRoot(){
		return true;
	}

	@Override
	public boolean isRoot(int length){
		return getLength() == length;
	}

	@Override
	public boolean isRoot(int minLength, int maxLength){
		if(minLength < 0)
			return false;
		if(maxLength == Parent.ANY_LENGTH)
			return getLength() >= minLength;
		else
			return getLength() >= minLength && getLength() <= maxLength;
	}
	
	@Override
	public boolean isParent(){
		return true;
	}

	@Override
	public boolean isParent(int length){
		return getLength() == length;
	}
	
	@Override
	public boolean isParent(int minLength, int maxLength){
		if(minLength < 0)
			return false;
		if(maxLength == Parent.ANY_LENGTH)
			return getLength() >= minLength;
		else
			return getLength() >= minLength && getLength() <= maxLength;
	}
	
	@Override
	public boolean isNode(){
		return false;
	}

	@Override
	public Symbol asSymbol() throws ParseException {
		throw new ParseException(this, "Expected symbol, but encountered document root.");
	}

	@Override
	public Symbol asSymbol(String content) throws ParseException {
		throw new ParseException(this, "Expected \"" + content + "\", but encountered list.");
	}

	@Override
	public List asList() throws ParseException {
		throw new ParseException(this, "Expected list, but encountered document root.");
	}

	@Override
	public List asList(int length) throws ParseException {
		throw new ParseException(this, "Expected list of length " + length + ", but encountered document root.");
	}

	@Override
	public List asList(int minLength, int maxLength) throws ParseException {
		if(maxLength == Parent.ANY_LENGTH)
			throw new ParseException(this, "Expected list of length at least " + minLength + ", but encountered document root.");
		else
			throw new ParseException(this, "Expected list of length at least " + minLength + " but no more than " + maxLength + ", but encountered document root.");
	}

	@Override
	public Root asRoot() throws ParseException {
		return this;
	}

	@Override
	public Root asRoot(int length) throws ParseException {
		if(isRoot(length))
			return this;
		else
			throw new ParseException(this, "Expected " + length + " children, but encountered " + getLength() + ".");
	}

	@Override
	public Root asRoot(int minLength, int maxLength) throws ParseException {
		if(isRoot(minLength, maxLength))
			return this;
		else{
			if(maxLength == Parent.ANY_LENGTH)
				throw new ParseException(this, "Expected at least " + minLength + " children, but encountered " + getLength() + "t.");
			else
				throw new ParseException(this, "Expected at least " + minLength + " but no more than " + maxLength + " children, but encountered " + getLength() + ".");
		}
	}
	
	@Override
	public Parent asParent() throws ParseException {
		return this;
	}

	@Override
	public Parent asParent(int length) throws ParseException {
		if(isParent(length))
			return this;
		else
			throw new ParseException("Expected a list or document root of length " + length + ", but encountered a document root of length " + getLength() + ".");
	}

	@Override
	public Parent asParent(int minLength, int maxLength) throws ParseException {
		if(isParent(minLength, maxLength))
			return this;
		else{
			if(maxLength == Parent.ANY_LENGTH)
				throw new ParseException(this, "Expected a list or document root of length at least " + minLength + ", but encountered a document root of length " + getLength() + ".");
			else
				throw new ParseException(this, "Expected a list or document root of length at least " + minLength + " but no more than " + maxLength + ", but encountered a document root of length " + getLength() + ".");
		}
	}
	
	@Override
	public Node asNode() throws ParseException {
		throw new ParseException(this, "Expected a list or a symbol, but encountered document root.");
	}

	@Override
	public int getLength(){
		return children.getLength();
	}
	
	@Override
	public Iterator<Node> iterator(){
		return children.iterator();
	}

	@Override
	public Node getChild(int index) throws ParseException {
		return children.getChild(index);
	}

	@Override
	public int indexOf(Node child){
		return children.indexOf(child);
	}
	
	@Override
	public int indexOf(String symbol){
		return children.indexOf(symbol);
	}

	@Override
	public void addChild(SExpression child) throws BuildException {
		children.addChild(child);
	}
	
	@Override
	public void addChild(String symbol) throws BuildException {
		children.addChild(symbol);
	}

	@Override
	public void addChild(int index, SExpression child) throws BuildException {
		children.addChild(index, child);
	}
	
	@Override
	public void addChild(int index, String symbol) throws BuildException {
		children.addChild(index, symbol);
	}

	@Override
	public void removeChild(Node child) throws BuildException {
		children.removeChild(child);
	}
	
	@Override
	public void removeChild(String symbol) throws BuildException {
		children.removeChild(symbol);
	}

	@Override
	public void removeChild(int index) throws BuildException {
		children.removeChild(index);
	}
	
	@Override
	public void replaceChild(Node toReplace, Node replacement) throws BuildException {
		children.replaceChild(toReplace, replacement);
	}
	
	@Override
	public void replaceChild(String toReplace, String replacement) throws BuildException {
		children.replaceChild(toReplace, replacement);
	}
	
	@Override
	public void replaceChild(int index, Node replacement) throws BuildException {
		children.replaceChild(index, replacement);
	}
	
	@Override
	public void replaceChild(int index, String replacement) throws BuildException {
		children.replaceChild(index, replacement);
	}
	
	@Override
	public Symbol findSymbol(String symbol){
		return children.findSymbol(symbol);
	}

	@Override
	public Symbol requireSymbol(String symbol) throws ParseException {
		return children.requireSymbol(symbol);
	}

	@Override
	public List findListStartingWith(String symbol){
		return children.findListStartingWith(symbol);
	}

	@Override
	public List requireListStartingWith(String symbol) throws ParseException {
		return children.requireListStartingWith(symbol);
	}

	@Override
	public java.util.List<List> findListsStartingWith(String symbol){
		return children.findListsStartingWith(symbol);
	}

	@Override
	public java.util.List<List> requireListsStartingWith(String symbol) throws ParseException {
		return children.requireListsStartingWith(symbol);
	}

	@Override
	public FormatRule getFormatRule(){
		return formatRule;
	}

	@Override
	public void setFormatRule(FormatRule formatRule) {
		this.formatRule = formatRule;
	}
	
	@Override
	public void write(Writer writer) throws IOException {
		formatRule.format(this, writer);
	}
	
	@Override
	public String toString(){
		return children.toString();
	}
}
