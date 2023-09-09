package com.stephengware.java.planware.io.pddl.types;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.Type;

public class TypedTermVariableExtension extends SimpleExtension<SExpression, TermVariable> {

	public TypedTermVariableExtension(){
		super(TermVariable.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(parser.getUniverse() == null){
			String name = parser.require(Templates.VariableTemplate.NAME);
			Type type = parser.require(Templates.TermTemplate.TYPE);
			succeed(new TermVariable(name, type));
		}
	}

	@Override
	public SExpression build(TermVariable object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
