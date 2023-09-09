package com.stephengware.java.planware.io.pddl.strips;

import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Utilities;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Variable;

public class OperatorExtension extends SimpleExtension<SExpression, Operator> {

	public static final String OPERATOR_IDENTIFIER = ":action";
	public static final String PARAMETERS_IDENTIFIER = ":parameters";
	public static final String PRECONDITION_IDENTIFIER = ":precondition";
	public static final String EFFECT_IDENTIFIER = ":effect";
	
	public OperatorExtension(){
		super(Operator.class, true);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		String name = parseName(document.asList(), parser);
		Variable[] parameters = parseParameters(document.asList(), parser);
		Expression precondition = parsePrecondition(document.asList(), parser);
		Expression effect = parseEffect(document.asList(), parser);
		succeed(new Operator(name, parameters, precondition, effect));
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(2, -1) &&
				document.asList().getChild(0).isSymbol(OPERATOR_IDENTIFIER);
	}
	
	protected String parseName(List document, Parser<SExpression> parser) throws ParseException {
		String name = document.getChild(1).asSymbol().content;
		parser.define(Templates.OperatorTemplate.NAME, name);
		return name;
	}
	
	protected Variable[] parseParameters(List document, Parser<SExpression> parser) throws ParseException {
		Symbol parametersSymbol = document.findSymbol(PARAMETERS_IDENTIFIER);
		Variable[] parameters;
		if(parametersSymbol == null)
			parameters = new Variable[0];
		else
			parameters = Utilities.parseParameters(parametersSymbol.requireNextSibling().asList(), parser);
		parser.define(Templates.OperatorTemplate.PARAMETERS, parameters);
		return parameters;
	}
	
	protected Expression parsePrecondition(List document, Parser<SExpression> parser) throws ParseException {
		Expression precondition;
		Symbol preconditionSymbol = document.findSymbol(PRECONDITION_IDENTIFIER);
		if(preconditionSymbol == null)
			precondition = Expression.TRUE;
		else
			precondition = PDDLManager.parseGoal(preconditionSymbol.requireNextSibling(), parser);
		parser.define(Templates.OperatorTemplate.PRECONDITION, precondition);
		return precondition;
	}
	
	protected Expression parseEffect(List document, Parser<SExpression> parser) throws ParseException {
		Expression effect;
		Symbol effectSymbol = document.findSymbol(EFFECT_IDENTIFIER);
		if(effectSymbol == null)
			effect = Expression.TRUE;
		else
			effect = PDDLManager.parseEffect(effectSymbol.requireNextSibling(), parser);
		parser.define(Templates.OperatorTemplate.EFFECT, effect);
		return effect;
	}

	@Override
	public SExpression build(Operator operator, SExpression document, Builder<SExpression> builder) throws BuildException {
		List operatorList = new List(OPERATOR_IDENTIFIER);
		operatorList.setFormatRule(FormatRule.KEYWORD_ON_NEW_LINE);
		buildName(operator, operatorList, builder);
		buildParameters(operator, operatorList, builder);
		buildPrecondition(operator, operatorList, builder);
		buildEffect(operator, operatorList, builder);
		return operatorList;
	}
	
	protected void buildName(Operator operator, List document, Builder<SExpression> builder) throws BuildException {
		document.addChild(operator.name);
	}
	
	protected void buildParameters(Operator operator, List document, Builder<SExpression> builder) throws BuildException {
		SExpression parametersList = Utilities.buildParameters(operator.parameters.toArray(), builder);
		if(parametersList instanceof List){
			document.addChild(PARAMETERS_IDENTIFIER);
			document.addChild(parametersList);
		}
	}
	
	protected void buildPrecondition(Operator operator, List document, Builder<SExpression> builder) throws BuildException {
		if(operator.precondition == Expression.TRUE)
			return;
		document.addChild(PRECONDITION_IDENTIFIER);
		document.addChild(builder.build(operator.precondition));
	}

	protected void buildEffect(Operator operator, List document, Builder<SExpression> builder) throws BuildException {
		if(operator.effect == Expression.TRUE)
			return;
		document.addChild(EFFECT_IDENTIFIER);
		document.addChild(builder.build(operator.effect));
	}
}
