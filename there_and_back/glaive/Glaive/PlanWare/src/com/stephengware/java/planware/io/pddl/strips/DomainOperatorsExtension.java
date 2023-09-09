package com.stephengware.java.planware.io.pddl.strips;

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

public class DomainOperatorsExtension extends SimpleExtension<SExpression, Domain> {

	public DomainOperatorsExtension(){
		super(Domain.class);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.DomainTemplate.NAME);
		Universe universe = parser.require(Templates.DomainTemplate.UNIVERSE);
		Operator[] operators = parseOperators(document.asList(), parser);
		parser.define(Templates.DomainTemplate.OPERATORS, operators);
		AxiomTemplate[] axioms = parser.require(Templates.DomainTemplate.AXIOMS);
		succeed(new Domain(name, universe, operators, axioms));
	}
	
	protected Operator[] parseOperators(List document, Parser<SExpression> parser) throws ParseException {
		LinkedList<Operator> operators = new LinkedList<>();
		for(List operatorList : document.findListsStartingWith(OperatorExtension.OPERATOR_IDENTIFIER))
			operators.add(parser.parseOrFail(operatorList, Operator.class));
		return operators.toArray(new Operator[operators.size()]);
	}

	@Override
	public SExpression build(Domain domain, SExpression document, Builder<SExpression> builder) throws BuildException {
		buildOperators(domain, (List) document, builder);
		return document;
	}
	
	protected void buildOperators(Domain domain, List document, Builder<SExpression> builder) throws BuildException {
		for(Operator operator : domain.operators)
			document.addChild(builder.build(operator));
	}
}