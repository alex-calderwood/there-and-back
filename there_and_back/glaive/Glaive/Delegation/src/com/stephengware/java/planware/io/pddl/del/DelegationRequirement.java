package com.stephengware.java.planware.io.pddl.del;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Delegation;
import com.stephengware.java.planware.util.ImmutableArray;

public class DelegationRequirement extends Requirement {

	private static final Extension<SExpression, SExpression> DELEGATION_EXTENSION = new DelegationExtension();
	private static final Extension<SExpression, SExpression> UNIVERSE_DELEGATION_EXTENSION = new UniverseDelegationExtension();
	private static final Extension<SExpression, SExpression> DOMAIN_DELEGATION_EXTENSION = new DomainDelegationExtension();
	
	public static final Requirement DELEGATION = new DelegationRequirement();
	
	private DelegationRequirement(){
		super("delegation", "goal delegation", DELEGATION_EXTENSION, UNIVERSE_DELEGATION_EXTENSION, DOMAIN_DELEGATION_EXTENSION);
	}
	
	private static final ImmutableArray<Requirement> PREREQUISITES = new ImmutableArray<>(new Requirement[]{
			com.stephengware.java.planware.io.pddl.expvar.ExpressionVariablesRequirement.EXPRESSION_VARIABLES,
			com.stephengware.java.planware.io.pddl.intp.IntentionalityRequirement.INTENTIONALITY
	});
	
	@Override
	public Iterable<Requirement> getPrerequisites(){
		return PREREQUISITES;
	}
	
	@Override
	protected void load(Parser<SExpression> parser){
		super.load(parser);
		PDDLManager.allowGoalType(Delegation.class, parser);
		PDDLManager.allowEffectType(Delegation.class, parser);
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		return domain.universe.collect(Delegation.class).size() != 0;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return problem.universe.collect(Delegation.class).size() != 0;
	}
}
