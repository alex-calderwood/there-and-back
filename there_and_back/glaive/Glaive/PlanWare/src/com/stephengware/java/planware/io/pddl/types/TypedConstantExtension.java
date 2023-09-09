package com.stephengware.java.planware.io.pddl.types;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Type;

public class TypedConstantExtension extends SimpleExtension<SExpression, Constant> {

	public TypedConstantExtension(){
		super(Constant.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(parser.getUniverse() == null){
			String name = parser.require(Templates.TermTemplate.NAME);
			Type type = parser.require(Templates.TermTemplate.TYPE);
			succeed(new Constant(name, type));
		}
	}

	@Override
	public SExpression build(Constant constant, SExpression document, Builder<SExpression> builder) throws BuildException {
		if(builder.getUniverse() == null)
			return document;
		else
			return new Symbol(constant.name);
	}
}
