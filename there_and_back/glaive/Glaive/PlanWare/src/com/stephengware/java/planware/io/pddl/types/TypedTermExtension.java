package com.stephengware.java.planware.io.pddl.types;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.Root;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Term;
import com.stephengware.java.planware.logic.Type;

public class TypedTermExtension extends SimpleExtension<SExpression, Term> {

	public TypedTermExtension(){
		super(Term.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(parser.getUniverse() == null){
			Type type = parser.parseOrFail(TypeExtension.findTypeSymbol(document), Type.class);
			parser.define(Templates.TermTemplate.TYPE, type);
		}
	}

	@Override
	public SExpression build(Term term, SExpression document, Builder<SExpression> builder) throws BuildException {
		if(builder.getUniverse() == null){
			Root root;
			if(document instanceof Root)
				root = (Root) document;
			else
				root = new Root(document);
			root.addChild("-");
			root.addChild(term.getType().name);
			return root;
		}
		else
			return document;
	}
}
