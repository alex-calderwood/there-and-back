package com.stephengware.java.planware.io.pddl.intp;

import java.util.LinkedList;

import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.logic.Term;

public class OperatorAgentsExtension extends SimpleExtension<SExpression, Operator> {

	public static final String AGENTS_IDENTIFIER = ":agents";
	
	public OperatorAgentsExtension(){
		super(Operator.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		LinkedList<Term> agents = new LinkedList<>();
		Symbol agentsSymbol = document.asList().findSymbol(AGENTS_IDENTIFIER);
		if(agentsSymbol != null)
			for(Node node : parser.parseOrFail(agentsSymbol.requireNextSibling().asList().getChild(0), Node[].class))
				agents.add(parser.parseOrFail(node, Term.class));
		parser.define(Templates.IntentionalOperatorTemplate.AGENTS, agents.toArray(new Term[agents.size()]));
	}

	@Override
	public SExpression build(Operator object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
