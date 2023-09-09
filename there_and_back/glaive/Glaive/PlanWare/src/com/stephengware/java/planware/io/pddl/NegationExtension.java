package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Negation;

public class NegationExtension extends BooleanExpressionExtension<Negation, Expression> {
	
	public static final String NEGATION_OPERATOR = "not";
	
	public NegationExtension(){
		super(Negation.class, NEGATION_OPERATOR, Expression.class, 1, 1);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		Negation negation = parseBooleanExpression(document, parser);
		parser.define(Templates.NegationTemplate.ARGUMENT, negation.argument);
		succeed(negation);
	}

	@Override
	protected Negation construct(Expression[] arguments){
		return new Negation(arguments[0]);
	}
}
