package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.logic.Variable;

public class VariableExtension extends SimpleExtension<SExpression, Variable> {

	public VariableExtension(){
		super(Variable.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		String name = document.asSymbol().content;
		if(parser.isReservedKeyword(name))
			throw new ParseException("The name \"" + name + "\" is not a valid name for a variable because it is a reserved keyword.");
		name = name.substring(1);
		parser.define(Templates.VariableTemplate.NAME, name);
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isSymbol() &&
				document.asSymbol().content.startsWith("?") &&
				document.asSymbol().content.length() > 1;
	}
	
	@Override
	public SExpression build(Variable variable, SExpression document, Builder<SExpression> builder) throws BuildException {
		return new Symbol("?" + variable.name);
	}
}
