package com.stephengware.java.planware.io.pddl.ax;

import java.util.LinkedList;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.Templates;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public class DomainAxiomsExtension extends SimpleExtension<SExpression, Domain> {
	
	public DomainAxiomsExtension(){
		super(Domain.class);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.DomainTemplate.NAME);
		Universe universe = parser.require(Templates.DomainTemplate.UNIVERSE);
		Operator[] operators = parser.require(Templates.DomainTemplate.OPERATORS);
		AxiomTemplate[] axioms = parseAxioms(document.asList(), parser);
		parser.define(Templates.DomainTemplate.AXIOMS, axioms);
		succeed(new Domain(name, universe, operators, axioms));
	}
	
	protected AxiomTemplate[] parseAxioms(List document, Parser<SExpression> parser) throws ParseException {
		LinkedList<AxiomTemplate> axioms = new LinkedList<>();
		for(List axiomList : document.findListsStartingWith(AxiomTemplateExtension.AXIOM_IDENTIFIER))
			axioms.add(parser.parseOrFail(axiomList, AxiomTemplate.class));
		return axioms.toArray(new AxiomTemplate[axioms.size()]);
	}

	@Override
	public SExpression build(Domain domain, SExpression document, Builder<SExpression> builder) throws BuildException {
		buildAxioms(domain, (List) document, builder);
		return document;
	}
	
	protected void buildAxioms(Domain domain, List document, Builder<SExpression> builder) throws BuildException {
		for(AxiomTemplate axiom : domain.axioms)
			document.addChild(builder.build(axiom));
	}
}