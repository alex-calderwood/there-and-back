package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public class DomainExtension extends SimpleExtension<SExpression, Domain> {

	public static final String DOMAIN_IDENTIFIER = "domain";
	
	public DomainExtension(){
		super(Domain.class, true);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		String name = parseName(document.asList(), parser);
		parseRequirements(document.asList(), parser);
		Universe universe = parseUniverse(document.asList(), parser);
		Operator[] operators = parseOperators(document.asList(), parser);
		AxiomTemplate[] axioms = parseAxioms(document.asList(), parser);
		succeed(new Domain(name, universe, operators, axioms));
	}
		
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(2, -1) &&
				document.asList().getChild(0).isSymbol(PDDLManager.DEFINITION_KEYWORD) &&
				document.asList().getChild(1).isList(2) &&
				document.asList().getChild(1).asList().getChild(0).isSymbol(DOMAIN_IDENTIFIER);
	}
	
	protected String parseName(List document, Parser<SExpression> parser) throws ParseException {
		String name = document.getChild(1).asList().getChild(1).asSymbol().content;
		parser.define(Templates.DomainTemplate.NAME, name);
		return name;
	}
	
	protected Requirement[] parseRequirements(List document, Parser<SExpression> parser) throws ParseException {
		Requirement[] requirements = Utilities.parseRequirements(document, parser);
		for(Requirement requirement : requirements)
			requirement.load(parser);
		parser.define(Templates.DomainTemplate.REQUIREMENTS, requirements);
		return requirements;
	}
	
	protected Universe parseUniverse(List document, Parser<SExpression> parser) throws ParseException {
		Universe universe = parser.parseOrFail(document, Universe.class);
		parser.setUniverse(universe);
		parser.define(Templates.DomainTemplate.UNIVERSE, universe);
		return universe;
	}
	
	protected Operator[] parseOperators(List document, Parser<SExpression> parser) throws ParseException {
		Operator[] operators = new Operator[0];
		parser.define(Templates.DomainTemplate.OPERATORS, operators);
		return operators;
	}
	
	protected AxiomTemplate[] parseAxioms(List document, Parser<SExpression> parser) throws ParseException {
		AxiomTemplate[] axioms = new AxiomTemplate[0];
		parser.define(Templates.DomainTemplate.AXIOMS, axioms);
		return axioms;
	}
	
	@Override
	public SExpression build(Domain domain, SExpression document, Builder<SExpression> builder) throws BuildException {
		List domainList = new List(PDDLManager.DEFINITION_KEYWORD);
		domainList.setFormatRule(FormatRule.PDDL_DOCUMENT);
		buildName(domain, domainList, builder);
		buildRequirements(domain, domainList, builder);
		buildUniverse(domain, domainList, builder);
		buildOperators(domain, domainList, builder);
		buildAxioms(domain, domainList, builder);	
		return domainList;
	}
	
	protected void buildName(Domain domain, List document, Builder<SExpression> builder) throws BuildException {
		document.addChild(new List(DOMAIN_IDENTIFIER, domain.name));
	}
	
	protected void buildRequirements(Domain domain, List document, Builder<SExpression> builder) throws BuildException {
		Requirement[] requirements = Utilities.getRequirementsFor(domain, builder);
		for(Requirement requirement : requirements)
			requirement.load(builder);
		document.addChild(Utilities.buildRequirements(requirements));
	}
	
	protected void buildUniverse(Domain domain, List document, Builder<SExpression> builder) throws BuildException {
		document.addChild(builder.build(domain.universe));
		builder.setUniverse(domain.universe);
	}
	
	protected void buildOperators(Domain domain, List document, Builder<SExpression> builder) throws BuildException {
		// do nothing
	}
	
	protected void buildAxioms(Domain domain, List document, Builder<SExpression> builder) throws BuildException {
		// do nothing
	}
}
