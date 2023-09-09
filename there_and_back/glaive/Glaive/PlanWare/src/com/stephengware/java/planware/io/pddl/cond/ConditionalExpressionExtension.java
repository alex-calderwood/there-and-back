package com.stephengware.java.planware.io.pddl.cond;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.ConditionalExpression;
import com.stephengware.java.planware.logic.Expression;

public class ConditionalExpressionExtension extends SimpleExtension<SExpression, ConditionalExpression> {

	public static final String CONDITION_PREDICATE = "when";
	
	public ConditionalExpressionExtension(){
		super(ConditionalExpression.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		Node[] arguments = parser.parseOrFail(document.asList().getChild(1), Node[].class);
		if(arguments.length != 2)
			throw new ParseException(document, "Conditional expression expects exactly 2 arguments, but encountered " + arguments.length + " arguments.");
		Expression condition = parser.parseOrFail(arguments[0], Expression.class);
		Expression effect = parser.parseOrFail(arguments[1], Expression.class);
		parser.define(Templates.ConditionalExpressionTemplate.CONDITION, condition);
		parser.define(Templates.ConditionalExpressionTemplate.EFFECT, effect);
		succeed(new ConditionalExpression(condition, effect));
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) &&
				document.asList().getChild(0).isSymbol(CONDITION_PREDICATE);
	}
	
	@Override
	public SExpression build(ConditionalExpression condExpression, SExpression document, Builder<SExpression> builder) throws BuildException {
		return new List(CONDITION_PREDICATE, builder.build(condExpression.condition), builder.build(condExpression.effect));
	}
}
