package com.stephengware.java.planware.io.pddl.sexp;

import java.io.IOException;
import java.io.Writer;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.ParseException;

public final class Symbol extends Node {

	public final String content;
	
	Symbol(String content, int lineNumber) throws BuildException {
		super(lineNumber);
		if(content == null)
			throw new BuildException("Symbol cannot be null.");
		this.content = content;
	}	
	
	public Symbol(String content) throws BuildException {
		this(content, NO_LINE_NUMBER);
	}

	@Override
	public boolean isSymbol(){
		return true;
	}

	@Override
	public boolean isSymbol(String content){
		return this.content.equals(content);
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
		return false;
	}
	
	@Override
	public boolean isRoot(int length){
		return false;
	}
	
	@Override
	public boolean isRoot(int minLength, int maxLength){
		return false;
	}
	
	@Override
	public boolean isParent(){
		return false;
	}

	@Override
	public boolean isParent(int length){
		return false;
	}

	@Override
	public boolean isParent(int minLength, int maxLength){
		return false;
	}
	
	@Override
	public boolean isNode(){
		return true;
	}
	
	@Override
	public Node asNode() throws ParseException {
		return this;
	}

	@Override
	public Symbol asSymbol() throws ParseException {
		return this;
	}

	@Override
	public Symbol asSymbol(String content) throws ParseException {
		if(isSymbol(content))
			return this;
		else
			throw new ParseException(this, "Expected \"" + content + "\", but encountered \"" + this.content + "\".");
	}

	@Override
	public List asList() throws ParseException {
		throw new ParseException(this, "Expected list, but encountered \"" + this.content + "\".");
	}

	@Override
	public List asList(int length) throws ParseException {
		throw new ParseException(this, "Expected list of length " + length + ", but encountered \"" + this.content + "\".");
	}

	@Override
	public List asList(int minLength, int maxLength) throws ParseException {
		if(maxLength == Parent.ANY_LENGTH)
			throw new ParseException(this, "Expected list of length at least " + minLength + ", but encountered \"" + this.content + "\".");
		else
			throw new ParseException(this, "Expected list of length at least " + minLength + " and at most " + maxLength + ", but encountered \"" + this.content + "\".");
	}
	
	@Override
	public Root asRoot() throws ParseException {
		throw new ParseException(this, "Expected document root, but encountered \"" + content + "\".");
	}
	
	@Override
	public Root asRoot(int length) throws ParseException {
		throw new ParseException(this, "Expected document root with " + length + " children, but encountered \"" + content + "\".");
	}
	
	@Override
	public Root asRoot(int minLength, int maxLength) throws ParseException {
		if(maxLength == Parent.ANY_LENGTH)
			throw new ParseException(this, "Expected document root with at least " + minLength + " children, but encountered \"" + content + "\".");
		else
			throw new ParseException(this, "Expected document root with at least " + minLength + " but no more than " + maxLength + " children, but encountered \"" + content + "\".");
	}
	
	@Override
	public void write(Writer writer) throws IOException {
		writer.append(content);
	}

	@Override
	public String toString(){
		return content;
	}

	@Override
	public Parent asParent() throws ParseException {
		throw new ParseException(this, "Expected a list or document root, but encountered \"" + content + "\".");
	}

	@Override
	public Parent asParent(int length) throws ParseException {
		throw new ParseException(this, "Expected a list or document root with " + length + " children, but encountered \"" + content + "\".");
	}

	@Override
	public Parent asParent(int minLength, int maxLength) throws ParseException {
		if(maxLength == Parent.ANY_LENGTH)
			throw new ParseException(this, "Expected a list or document root with at least " + minLength + " children, but encountered \"" + content + "\".");
		else
			throw new ParseException(this, "Expected a list or document root with at least " + minLength + " but no more than " + maxLength + " children, but encountered \"" + content + "\".");
	}
}
