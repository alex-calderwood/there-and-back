package com.stephengware.java.planware.io.pddl.expvar;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.ExpressionVariable;

public class ExpressionVariablesRequirement extends Requirement {

	private static final Extension<SExpression, SExpression> EXPRESSION_VARIABLE_EXTENSION = new ExpressionVariableExtension();
	private static final Extension<SExpression, SExpression> RESERVED_TYPES_EXTENSION = new ReserveExpressionVariableTypesExtension();
	
	public static final Requirement EXPRESSION_VARIABLES = new ExpressionVariablesRequirement();
	
	private ExpressionVariablesRequirement(){
		super("expression-variables", "variables bound to expressions", EXPRESSION_VARIABLE_EXTENSION, RESERVED_TYPES_EXTENSION);
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}
	
	@Override
	protected void load(Parser<SExpression> parser){
		super.load(parser);
		PDDLManager.allowGoalType(ExpressionVariable.class, parser);
		PDDLManager.allowEffectType(ExpressionVariable.class, parser);
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		return domain.collect(ExpressionVariable.class).size() > 0;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return problem.collect(ExpressionVariable.class).size() > 0;
	}
}
