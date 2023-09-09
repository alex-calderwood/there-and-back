package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.NegatedLiteral;

public class NegatedLiteralExtension extends SimpleExtension<SExpression, NegatedLiteral> {
	
	public NegatedLiteralExtension(){
		super(NegatedLiteral.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		Expression argument = parser.require(Templates.NegationTemplate.ARGUMENT);
		if(argument instanceof Literal){
			Literal literalArgument = (Literal) argument;
			parser.define(Templates.NegatedLiteralTemplate.ARGUMENT, literalArgument);
			succeed(new NegatedLiteral(literalArgument));
		}
		else
			fail();
	}
	
	@Override
	public SExpression build(NegatedLiteral object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
