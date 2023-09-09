package com.stephengware.java.planware.io.pddl.negp;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Negation;

public class NegativePreconditionsRequirement extends Requirement {
	
	public static final Requirement NEGATIVE_PRECONDITIONS = new NegativePreconditionsRequirement();
	
	private NegativePreconditionsRequirement(){
		super("negative-preconditions", "negated preconditions and goals");
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}
	
	
	@Override
	public void load(Parser<SExpression> parser){
		super.load(parser);
		PDDLManager.allowGoalType(Negation.class, parser);
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		for(Operator operator : domain.operators)
			if(operator.precondition.collect(Negation.class).size() > 0)
				return true;
		for(AxiomTemplate axiom : domain.axioms)
			if(axiom.context.collect(Negation.class).size() > 0)
				return true;
		return false;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return problem.goal.toDNF().collect(Negation.class).size() > 0;
	}
}
