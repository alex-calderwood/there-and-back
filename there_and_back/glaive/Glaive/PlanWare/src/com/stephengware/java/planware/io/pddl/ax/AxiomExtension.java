package com.stephengware.java.planware.io.pddl.ax;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.logic.Expression;

public class AxiomExtension extends SimpleExtension<SExpression, Axiom> {

	public static final String AXIOM_IDENTIFIER = ":axiom";
	public static final String CONTEXT_IDENTIFIER = ":context";
	public static final String IMPLIES_IDENTIFIER = ":implies";
	
	public AxiomExtension(){
		super(Axiom.class, true);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		Expression context = parseContext(document.asList(), parser);
		Expression implies = parseImplies(document.asList(), parser);
		succeed(new Axiom(context, implies));
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) && document.asList().getChild(0).isSymbol(AXIOM_IDENTIFIER);
	}
	
	protected Expression parseContext(List document, Parser<SExpression> parser) throws ParseException {
		Symbol contextSymbol = document.findSymbol(CONTEXT_IDENTIFIER);
		Expression context;
		if(contextSymbol == null)
			context = Expression.TRUE;
		else
			context = parser.parseOrFail(contextSymbol.requireNextSibling(), Expression.class);
		parser.define(Templates.AxiomTemplate.CONTEXT, context);
		return context;
	}
	
	protected Expression parseImplies(List document, Parser<SExpression> parser) throws ParseException {
		Symbol impliesSymbol = document.findSymbol(IMPLIES_IDENTIFIER);
		Expression implies;
		if(impliesSymbol == null)
			implies = Expression.TRUE;
		else
			implies = parser.parseOrFail(impliesSymbol.requireNextSibling(), Expression.class);
		parser.define(Templates.AxiomTemplate.IMPLIES, implies);
		return implies;
	}

	@Override
	public SExpression build(Axiom axiom, SExpression document, Builder<SExpression> builder) throws BuildException {
		List axiomList = new List(AXIOM_IDENTIFIER);
		axiomList.setFormatRule(FormatRule.KEYWORD_ON_NEW_LINE);
		if(axiom.context != Expression.TRUE){
			axiomList.addChild(CONTEXT_IDENTIFIER);
			axiomList.addChild(builder.build(axiom.context));
		}
		axiomList.addChild(IMPLIES_IDENTIFIER);
		axiomList.addChild(builder.build(axiom.implies));
		return axiomList;
	}
}
