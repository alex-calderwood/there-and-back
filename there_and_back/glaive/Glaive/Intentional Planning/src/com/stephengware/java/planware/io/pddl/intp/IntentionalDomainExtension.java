package com.stephengware.java.planware.io.pddl.intp;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.IntentionalDomain;
import com.stephengware.java.planware.IntentionalOperator;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public class IntentionalDomainExtension extends SimpleExtension<SExpression, IntentionalDomain> {

	public IntentionalDomainExtension(){
		super(IntentionalDomain.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.IntentionalDomainTemplate.NAME);
		Universe universe = parser.require(Templates.IntentionalDomainTemplate.UNIVERSE);
		Operator[] operators = parser.require(com.stephengware.java.planware.io.Templates.DomainTemplate.OPERATORS);
		IntentionalOperator[] bdiOperators = new IntentionalOperator[operators.length];
		for(int i=0; i<operators.length; i++){
			if(operators[i] instanceof IntentionalOperator)
				bdiOperators[i] = (IntentionalOperator) operators[i];
			else
				fail();
		}
		parser.define(Templates.IntentionalDomainTemplate.OPERATORS, bdiOperators);
		AxiomTemplate[] axioms = parser.require(Templates.IntentionalDomainTemplate.AXIOMS);
		succeed(new IntentionalDomain(name, universe, bdiOperators, axioms));
	}
	
	@Override
	public SExpression build(IntentionalDomain object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
