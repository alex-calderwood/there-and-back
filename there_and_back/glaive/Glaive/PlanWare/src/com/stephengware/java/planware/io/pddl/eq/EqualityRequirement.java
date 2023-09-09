package com.stephengware.java.planware.io.pddl.eq;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Equality;

public class EqualityRequirement extends Requirement {

	private static final Extension<SExpression, SExpression> TERM_EQUALITY_EXTENSION = new TermEqualityExtension();
	private static final Extension<SExpression, SExpression> EXPRESSION_EQUALITY_EXTENSION = new ExpressionEqualityExtension();
	
	public static final Requirement EQUALITY = new EqualityRequirement();
	
	private EqualityRequirement(){
		super("equality", "equality predicates", TERM_EQUALITY_EXTENSION, EXPRESSION_EQUALITY_EXTENSION);
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}

	@Override
	public void load(Parser<SExpression> parser){
		super.load(parser);
		PDDLManager.allowGoalType(Equality.class, parser);
	}
	
	@Override
	public boolean isRequiredBy(Domain domain){
		return domain.collect(Equality.class).size() > 0;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return problem.collect(Equality.class).size() > 0;
	}
}
