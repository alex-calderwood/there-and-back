package com.stephengware.java.planware.io.pddl.intp;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Intention;

public class IntentionalityRequirement extends Requirement {

	private static final Extension<SExpression, SExpression> INTENTION_EXTENSION = new IntentionExtension();
	private static final Extension<SExpression, SExpression> UNIVERSE_INTENTION_EXTENSION = new UniverseIntentionExtension();
	private static final Extension<SExpression, SExpression> OPERATOR_AGENTS_EXTENSION = new OperatorAgentsExtension();
	private static final Extension<SExpression, SExpression> INTENTIONAL_OPERATOR_EXTENSION = new IntentionalOperatorExtension();
	private static final Extension<SExpression, SExpression> INTENTIONAL_DOMAIN_EXTENSION = new IntentionalDomainExtension();
	private static final Extension<SExpression, SExpression> INTENTIONAL_PROBLEM_EXTENSION = new IntentionalProblemExtension();
	private static final Extension<SExpression, SExpression> INTENTIONAL_STATE_SPACE_EXTENSION = new IntentionalStateSpaceExtension();
	
	public static final Requirement INTENTIONALITY = new IntentionalityRequirement();
	
	private IntentionalityRequirement(){
		super("intentionality", "intentional planning",
				INTENTION_EXTENSION,
				UNIVERSE_INTENTION_EXTENSION,
				OPERATOR_AGENTS_EXTENSION,
				INTENTIONAL_OPERATOR_EXTENSION,
				INTENTIONAL_DOMAIN_EXTENSION,
				INTENTIONAL_PROBLEM_EXTENSION,
				INTENTIONAL_STATE_SPACE_EXTENSION);
	}
	
	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}
	
	@Override
	protected void load(Parser<SExpression> parser){
		super.load(parser);
		PDDLManager.allowGoalType(Intention.class, parser);
		PDDLManager.allowEffectType(Intention.class, parser);
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		return domain.universe.collect(Intention.class).size() != 0;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return problem.universe.collect(Intention.class).size() != 0;
	}
}
