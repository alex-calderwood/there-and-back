package com.stephengware.java.planware.io.pddl.disjp;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Disjunction;

public class DisjunctivePreconditionsRequirement extends Requirement {

	public static final Requirement DISJUNCTIVE_PRECONDITIONS = new DisjunctivePreconditionsRequirement();
	
	private DisjunctivePreconditionsRequirement(){
		super("disjunctive-preconditions", "disjunctive preconditions and goals");
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}

	@Override
	protected void load(Parser<SExpression> parser){
		super.load(parser);
		PDDLManager.allowGoalType(Disjunction.class, parser);
	}
	
	@Override
	public boolean isRequiredBy(Domain domain){
		for(Operator operator : domain.operators)
			if(operator.precondition.toDNF().collect(Disjunction.class).size() > 0)
				return true;
		for(AxiomTemplate axiom : domain.axioms)
			if(axiom.context.toDNF().collect(Disjunction.class).size() > 0)
				return true;
		return false;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return problem.initialState.toDNF().collect(Disjunction.class).size() > 0;
	}
}
