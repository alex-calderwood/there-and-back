package com.stephengware.java.planware.io.pddl;

import java.lang.reflect.Array;
import java.util.Iterator;
import java.util.LinkedList;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.BooleanExpression;
import com.stephengware.java.planware.logic.Expression;

public abstract class BooleanExpressionExtension<B extends BooleanExpression, A extends Expression> extends SimpleExtension<SExpression, B> {
	
	protected final String operator;
	protected final Class<A> argumentType;
	protected final int minArguments;
	protected final int maxArguments;
	
	public BooleanExpressionExtension(Class<B> objectType, String operator, Class<A> argumentType, int minArguments, int maxArguments){
		super(objectType);
		this.operator = operator;
		this.argumentType = argumentType;
		this.minArguments = minArguments;
		this.maxArguments = maxArguments;
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		succeed(parseBooleanExpression(document, parser));
	}

	@SuppressWarnings("unchecked")
	protected B parseBooleanExpression(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		LinkedList<A> arguments = new LinkedList<>();
		Node[] argumentNodes = parser.parseOrFail(document.asList().getChild(1), Node[].class);
		checkArgumentCount(document, argumentNodes);
		for(Node node : argumentNodes)
			arguments.add(parser.parseOrFail(node, argumentType));
		A[] argumentsArray = arguments.toArray((A[]) Array.newInstance(argumentType, arguments.size()));
		parser.define(Templates.BooleanExpressionTemplate.ARGUMENTS, argumentsArray);
		return construct(argumentsArray);
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) &&
				document.asList().getChild(0).isSymbol(operator);
	}
	
	protected void checkArgumentCount(SExpression document, Node[] argumentNodes) throws ParseException {
		if(minArguments <= argumentNodes.length && maxArguments >= 0 ? argumentNodes.length <= maxArguments : true)
			return;
		String expected;
		if(minArguments == maxArguments)
			expected = "exactly " + minArguments;
		else if(maxArguments < 0)
			expected = "at least " + minArguments;
		else
			expected = "at least " + minArguments + " but no more than " + maxArguments;
		throw new ParseException(document, objectType.getSimpleName() + " expects " + expected + " arguments, but encountered " + argumentNodes.length + " arguments.");
	}
	
	protected abstract B construct(A[] arguments);
	
	@Override
	public SExpression build(B expression, SExpression document, Builder<SExpression> builder) throws BuildException {
		List expressionList = new List(operator);
		expressionList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(Iterator<? extends Expression> iterator = expression.iterator(); iterator.hasNext();)
			expressionList.addChild(builder.build(iterator.next()));
		return expressionList;
	}
}
