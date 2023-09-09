package com.stephengware.java.planware.io.pddl.del;

import java.util.Arrays;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.IntentionalDomain;
import com.stephengware.java.planware.IntentionalOperator;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.Templates;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Conjunction;
import com.stephengware.java.planware.logic.Delegation;
import com.stephengware.java.planware.logic.ExpressionVariable;
import com.stephengware.java.planware.logic.NegatedLiteral;
import com.stephengware.java.planware.logic.TermEquality;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.Variable;
import com.stephengware.java.planware.util.ImmutableArray;

public class DomainDelegationExtension extends SimpleExtension<SExpression, IntentionalDomain> {

	public DomainDelegationExtension(){
		super(IntentionalDomain.class);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.DomainTemplate.NAME);
		Universe universe = parser.require(Templates.DomainTemplate.UNIVERSE);
		IntentionalOperator[] operators = parser.require(com.stephengware.java.planware.io.pddl.intp.Templates.IntentionalDomainTemplate.OPERATORS);
		AxiomTemplate[] axioms = parser.require(Templates.DomainTemplate.AXIOMS);
		axioms = Arrays.copyOf(axioms, axioms.length + 1);
		axioms[axioms.length - 1] = makeDelegationAxiom();
		parser.define(Templates.DomainTemplate.AXIOMS, axioms);
		succeed(new IntentionalDomain(name, universe, operators, axioms));
	}
	
	private static final AxiomTemplate makeDelegationAxiom(){
		TermVariable master = new TermVariable("master");
		ExpressionVariable objective = new ExpressionVariable("objective");
		TermVariable slave = new TermVariable("slave");
		ImmutableArray<Variable> parameters = new ImmutableArray<>(new Variable[]{master, objective, slave});
		NegatedLiteral neq = new NegatedLiteral(new TermEquality(master, slave));
		Delegation delegation = new Delegation(master, objective, slave);
		Conjunction context = new Conjunction(neq, delegation, objective);
		return new AxiomTemplate(parameters, context, objective);
	}

	@Override
	public SExpression build(IntentionalDomain domain, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
