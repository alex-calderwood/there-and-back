package com.stephengware.java.planware.io.pddl.intp;

import com.stephengware.java.planware.IntentionalDomain;
import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Expression;

public class IntentionalProblemExtension extends SimpleExtension<SExpression, IntentionalProblem> {

	public IntentionalProblemExtension(){
		super(IntentionalProblem.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.IntentionalProblemTemplate.NAME);
		Domain domain = parser.require(com.stephengware.java.planware.io.Templates.ProblemTemplate.DOMAIN);
		if(domain instanceof IntentionalDomain)
			parser.define(Templates.IntentionalProblemTemplate.DOMAIN, (IntentionalDomain) domain);
		else
			fail();
		Universe universe = parser.require(Templates.IntentionalProblemTemplate.UNIVERSE);
		Expression initialState = parser.require(Templates.IntentionalProblemTemplate.INITIAL_STATE);
		Expression goal = parser.require(Templates.IntentionalProblemTemplate.GOAL);
		succeed(new IntentionalProblem(name, (IntentionalDomain) domain, universe, initialState, goal));
	}

	@Override
	public SExpression build(IntentionalProblem object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
