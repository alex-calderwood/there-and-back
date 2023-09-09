package com.stephengware.java.planware.io.pddl.intp;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.ss.IntentionalStateSpace;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionalStateSpaceExtension extends SimpleExtension<SExpression, IntentionalStateSpace> {

	public IntentionalStateSpaceExtension(){
		super(IntentionalStateSpace.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		Problem problem = parser.require(com.stephengware.java.planware.io.Templates.StateSpaceTemplate.PROBLEM);
		if(!(problem instanceof IntentionalProblem))
			fail();
		IntentionalProblem iproblem = (IntentionalProblem) problem;
		parser.define(Templates.IntentionalStateSpaceTemplate.PROBLEM, iproblem);
		Literal[] literals = parser.require(com.stephengware.java.planware.io.Templates.StateSpaceTemplate.LITERALS);
		Step[] steps = parser.require(com.stephengware.java.planware.io.Templates.StateSpaceTemplate.STEPS);
		IntentionalStep[] isteps = new IntentionalStep[steps.length];
		for(int i=0; i<steps.length; i++){
			if(steps[i] instanceof IntentionalStep)
				isteps[i] = (IntentionalStep) steps[i];
			else
				fail();
		}
		parser.define(Templates.IntentionalStateSpaceTemplate.STEPS, isteps);
		Axiom[] axioms = parser.require(com.stephengware.java.planware.io.Templates.StateSpaceTemplate.AXIOMS);
		succeed(new IntentionalStateSpace(iproblem, new ImmutableSet<Literal>(literals), new ImmutableSet<IntentionalStep>(isteps), new ImmutableSet<Axiom>(axioms)));
	}
	
	@Override
	public SExpression build(IntentionalStateSpace object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
