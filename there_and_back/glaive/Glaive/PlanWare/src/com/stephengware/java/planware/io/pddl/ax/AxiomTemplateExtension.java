package com.stephengware.java.planware.io.pddl.ax;

import com.stephengware.java.planware.AxiomTemplate;
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

public class AxiomTemplateExtension extends SimpleExtension<SExpression, AxiomTemplate> {

	public static final String AXIOM_IDENTIFIER = ":axiom";
	public static final String PARAMETERS_IDENTIFIER = ":vars";
	public static final String CONTEXT_IDENTIFIER = ":context";
	public static final String IMPLIES_IDENTIFIER = ":implies";
	
	public AxiomTemplateExtension(){
		super(AxiomTemplate.class, true);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		Variable[] parameters = parseParameters(document.asList(), parser);
		Expression context = parseContext(document.asList(), parser);
		Expression implies = parseImplies(document.asList(), parser);
		succeed(new AxiomTemplate(parameters, context, implies));
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) &&
				document.asList().getChild(0).isSymbol(AXIOM_IDENTIFIER);
	}
	
	protected Variable[] parseParameters(List document, Parser<SExpression> parser) throws ParseException {
		Symbol parametersSymbol = document.findSymbol(PARAMETERS_IDENTIFIER);
		Variable[] parameters;
		if(parametersSymbol == null)
			parameters = new Variable[0];
		else
			parameters = Utilities.parseParameters(parametersSymbol.requireNextSibling().asList(), parser);
		parser.define(Templates.AxiomTemplateTemplate.PARAMETERS, parameters);
		return parameters;
	}
	
	protected Expression parseContext(List document, Parser<SExpression> parser) throws ParseException {
		Symbol contextSymbol = document.findSymbol(CONTEXT_IDENTIFIER);
		Expression context;
		if(contextSymbol == null)
			context = Expression.TRUE;
		else
			context = PDDLManager.parseGoal(contextSymbol.requireNextSibling(), parser);
		parser.define(Templates.AxiomTemplateTemplate.CONTEXT, context);
		return context;
	}
	
	protected Expression parseImplies(List document, Parser<SExpression> parser) throws ParseException {
		Symbol impliesSymbol = document.findSymbol(IMPLIES_IDENTIFIER);
		Expression implies;
		if(impliesSymbol == null)
			implies = Expression.TRUE;
		else
			implies = PDDLManager.parseEffect(impliesSymbol.requireNextSibling(), parser);
		parser.define(Templates.AxiomTemplateTemplate.IMPLIES, implies);
		return implies;
	}
	
	@Override
	public SExpression build(AxiomTemplate axiom, SExpression document, Builder<SExpression> builder) throws BuildException {
		List axiomList = new List(AXIOM_IDENTIFIER);
		axiomList.setFormatRule(FormatRule.KEYWORD_ON_NEW_LINE);
		buildParameters(axiom, axiomList, builder);
		buildContext(axiom, axiomList, builder);
		buildImplies(axiom, axiomList, builder);
		return axiomList;
	}
	
	protected void buildParameters(AxiomTemplate axiom, List document, Builder<SExpression> builder) throws BuildException {
		SExpression parametersList = Utilities.buildParameters(axiom.parameters.toArray(), builder);
		if(parametersList instanceof List){
			document.addChild(PARAMETERS_IDENTIFIER);
			document.addChild(parametersList);
		}
	}
	
	protected void buildContext(AxiomTemplate axiom, List document, Builder<SExpression> builder) throws BuildException {
		if(axiom.context == Expression.TRUE)
			return;
		document.addChild(CONTEXT_IDENTIFIER);
		document.addChild(builder.build(axiom.context));
	}

	protected void buildImplies(AxiomTemplate axiom, List document, Builder<SExpression> builder) throws BuildException {
		if(axiom.implies == Expression.TRUE)
			return;
		document.addChild(IMPLIES_IDENTIFIER);
		document.addChild(builder.build(axiom.implies));
	}
}
