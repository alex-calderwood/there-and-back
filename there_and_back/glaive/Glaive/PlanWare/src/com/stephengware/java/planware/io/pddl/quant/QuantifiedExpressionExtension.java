package com.stephengware.java.planware.io.pddl.quant;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.Utilities;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.QuantifiedExpression;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.Variable;

public abstract class QuantifiedExpressionExtension<Q extends QuantifiedExpression> extends SimpleExtension<SExpression, Q> {

	private final String quantifier;
	
	public QuantifiedExpressionExtension(Class<Q> objectType, String quantifier){
		super(objectType);
		this.quantifier = quantifier;
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		succeed(parseQuantifiedExpression(document, parser));
	}

	protected Q parseQuantifiedExpression(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		Parser<SExpression> variableParser = parser.clone();
		variableParser.setUniverse(null);
		TermVariable variable = variableParser.parseOrFail(document.asList(3).getChild(1).asList(1, -1).getChild(0), TermVariable.class);
		parser.defineObject(variable.name, variable);
		Expression argument = parser.parseOrFail(document.asList().getChild(2), Expression.class);
		parser.define(Templates.QuantifiedExpressionTemplate.VARIABLE, variable);
		parser.define(Templates.QuantifiedExpressionTemplate.ARGUMENT, argument);
		return construct(variable, argument);
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) &&
				document.asList().getChild(0).isSymbol(quantifier);
	}
	
	protected abstract Q construct(TermVariable variable, Expression argument);
	
	@Override
	public SExpression build(Q quantifiedExpression, SExpression document, Builder<SExpression> builder) throws BuildException {
		List variableList = (List) Utilities.buildParameters(new Variable[]{quantifiedExpression.variable}, builder);
		List quantList = new List(quantifier, variableList, builder.build(quantifiedExpression.argument));
		quantList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		return quantList;
	}
}
