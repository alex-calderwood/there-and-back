package com.stephengware.java.planware.io.pddl.ax;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public class AxiomsRequirement extends Requirement {

	private static final Extension<SExpression, SExpression> AXIOM_TEMPLATE_EXTENSION = new AxiomTemplateExtension();
	private static final Extension<SExpression, SExpression> DOMAIN_AXIOMS_EXTENSION = new DomainAxiomsExtension();
	private static final Extension<SExpression, SExpression> AXIOM_EXTENSION = new AxiomExtension();
	
	public static final Requirement AXIOMS = new AxiomsRequirement();
	
	private AxiomsRequirement(){
		super("domain-axioms", "domain axioms", AXIOM_TEMPLATE_EXTENSION, DOMAIN_AXIOMS_EXTENSION, AXIOM_EXTENSION);
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		return domain.axioms.length > 0;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return false;
	}
}
