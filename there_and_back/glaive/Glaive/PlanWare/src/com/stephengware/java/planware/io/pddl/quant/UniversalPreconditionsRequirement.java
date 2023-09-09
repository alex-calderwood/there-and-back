package com.stephengware.java.planware.io.pddl.quant;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.UniversalQuantification;

public class UniversalPreconditionsRequirement extends QuantificationRequirement {

	public static final Requirement UNIVERSAL_PRECONDITIONS = new UniversalPreconditionsRequirement();
	
	private UniversalPreconditionsRequirement(){
		super("universal-preconditions", "universally quantified preconditions and goals");
	}
	
	@Override
	protected void load(Parser<SExpression> parser){
		super.load(parser);
		PDDLManager.allowGoalType(UniversalQuantification.class, parser);
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		for(Operator operator : domain.operators)
			if(operator.precondition.toDNF().collect(UniversalQuantification.class).size() > 0)
				return true;
		for(AxiomTemplate axiom : domain.axioms)
			if(axiom.context.toDNF().collect(UniversalQuantification.class).size() > 0)
				return true;
		return false;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return problem.goal.toDNF().collect(UniversalQuantification.class).size() > 0;
	}
}
