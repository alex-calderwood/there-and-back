package com.stephengware.java.planware.io.pddl.eq;

import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.ExpressionEquality;

public class ExpressionEqualityExtension extends EqualityExtension<ExpressionEquality, Expression> {

	public ExpressionEqualityExtension(){
		super(ExpressionEquality.class, Expression.class);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		ExpressionEquality expressionEquality = parseEquality(document, parser);
		parser.define(Templates.ExpressionEqualityTemplate.LEFT, expressionEquality.left);
		parser.define(Templates.ExpressionEqualityTemplate.RIGHT, expressionEquality.right);
		succeed(expressionEquality);
	}

	@Override
	protected ExpressionEquality construct(Expression left, Expression right){
		return new ExpressionEquality(left, right);
	}
}
