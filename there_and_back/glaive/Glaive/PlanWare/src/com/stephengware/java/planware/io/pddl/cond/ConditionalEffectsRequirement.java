package com.stephengware.java.planware.io.pddl.cond;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.ConditionalExpression;

public class ConditionalEffectsRequirement extends Requirement {

	private static final Extension<SExpression, SExpression> CONDITIONAL_EXPRESSION_EXTENSION = new ConditionalExpressionExtension();
	
	public static final Requirement CONDITIONAL_EFFECTS = new ConditionalEffectsRequirement();
	
	private ConditionalEffectsRequirement(){
		super("conditional-effects", "conditional effects", CONDITIONAL_EXPRESSION_EXTENSION);
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}
	
	@Override
	protected void load(Parser<SExpression> parser){
		super.load(parser);
		PDDLManager.allowEffectType(ConditionalExpression.class, parser);
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		return domain.collect(ConditionalExpression.class).size() > 0;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return problem.collect(ConditionalExpression.class).size() > 0;
	}
}
