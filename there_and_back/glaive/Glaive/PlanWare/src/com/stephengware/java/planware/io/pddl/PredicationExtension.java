package com.stephengware.java.planware.io.pddl;

import java.util.LinkedList;

import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Predication;
import com.stephengware.java.planware.logic.Term;

public class PredicationExtension extends SimpleExtension<SExpression, Predication> {

	public PredicationExtension(){
		super(Predication.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!document.isList(1, -1) || !document.asList().getChild(0).isSymbol())
			fail();		
		String predicate = document.asList().getChild(0).asSymbol().content;
		Universe universe = parser.getUniverse();
		if(universe != null){
			boolean valid = false;
			for(Predication template : universe.predicates){
				if(template.predicate.equals(predicate)){
					valid = true;
					break;
				}
			}
			if(!valid)
				fail();
		}
		LinkedList<Term> terms = new LinkedList<>();
		if(document.isList(2, -1)){
			for(Node node : parser.parseOrFail(document.asList().getChild(1), Node[].class)){
				Term term;
				if(universe == null){
					term = parser.parse(node, Term.class);
					if(term == null)
						fail();
				}
				else
					term = parser.parseOrFail(node, Term.class);
				terms.add(term);
			}
		}
		parser.define(Templates.PredicationTemplate.PREDICATE, predicate);
		parser.define(Templates.PredicationTemplate.TERMS, terms.toArray(new Term[terms.size()]));
		succeed(new Predication(predicate, terms));
	}
	
	@Override
	public SExpression build(Predication predication, SExpression document, Builder<SExpression> builder) throws BuildException {
		List predicationList = new List(predication.predicate);
		for(Term term : predication.terms)
			predicationList.addChild(builder.build(term));
		return predicationList;
	}
}
