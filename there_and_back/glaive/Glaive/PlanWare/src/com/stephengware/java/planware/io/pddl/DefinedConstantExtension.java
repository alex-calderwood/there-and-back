package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.logic.Constant;

public class DefinedConstantExtension extends SimpleExtension<SExpression, Constant> {

	public DefinedConstantExtension(){
		super(Constant.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.TermTemplate.NAME);
		Constant defined = parser.getDefinedObject(name, Constant.class);
		if(defined == null)
			throw new ParseException("The constant \"" + name + "\" is not defined.");
		else
			succeed(defined);
	}
	
	@Override
	public SExpression build(Constant constant, SExpression document, Builder<SExpression> builder) throws BuildException {
		return new Symbol(constant.name);
	}
}
