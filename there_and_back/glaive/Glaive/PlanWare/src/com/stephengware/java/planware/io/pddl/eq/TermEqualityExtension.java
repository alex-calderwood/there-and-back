package com.stephengware.java.planware.io.pddl.eq;

import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Term;
import com.stephengware.java.planware.logic.TermEquality;

public class TermEqualityExtension extends EqualityExtension<TermEquality, Term> {
	
	public TermEqualityExtension(){
		super(TermEquality.class, Term.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		TermEquality termEquality = parseEquality(document, parser);
		parser.define(Templates.TermEqualityTemplate.LEFT, termEquality.left);
		parser.define(Templates.TermEqualityTemplate.RIGHT, termEquality.right);
		succeed(termEquality);
	}
	
	@Override
	protected TermEquality construct(Term left, Term right){
		return new TermEquality(left, right);
	}
}
