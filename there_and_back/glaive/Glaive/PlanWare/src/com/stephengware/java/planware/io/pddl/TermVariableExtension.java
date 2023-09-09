package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.TermVariable;

public class TermVariableExtension extends SimpleExtension<SExpression, TermVariable> {

	public TermVariableExtension(){
		super(TermVariable.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.VariableTemplate.NAME);
		parser.define(Templates.TermTemplate.NAME, name);
		if(parser.getUniverse() == null)
			succeed(new TermVariable(name));
		else{
			TermVariable defined = parser.getDefinedObject(name, TermVariable.class);
			if(defined == null)
				throw new ParseException(document, "The variable \"?" + name + "\" is not defined.");
			else
				succeed(defined);
		}
	}

	@Override
	public SExpression build(TermVariable object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
