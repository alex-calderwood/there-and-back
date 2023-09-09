package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.logic.Term;
import com.stephengware.java.planware.logic.Type;

public class TermExtension extends SimpleExtension<SExpression, Term> {

	public TermExtension(){
		super(Term.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!document.isSymbol())
			fail();
		String name = document.asSymbol().content;
		if(parser.isReservedKeyword(name))
			throw new ParseException("The name \"" + name + "\" is not a valid name for a term because it is a reserved keyword.");
		parser.define(Templates.TermTemplate.NAME, name);
		parser.define(Templates.TermTemplate.TYPE, Type.UNIVERSAL_SUPERTYPE);
	}

	@Override
	public SExpression build(Term term, SExpression document, Builder<SExpression> builder) throws BuildException {
		return new Symbol(term.getName());
	}
}
