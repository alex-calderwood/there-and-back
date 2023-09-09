package com.stephengware.java.planware;

import com.stephengware.java.planware.ss.StateSpacePlanner;

public abstract class IntentionalPlanner extends Planner<IntentionalProblem> {

	public static final Argument<IntentionalDomain> DOMAIN = new Argument.ParsedArgument<>(StateSpacePlanner.DOMAIN.name, StateSpacePlanner.DOMAIN.abbreviation, IntentionalDomain.class);
	
	public static final Argument<IntentionalProblem> PROBLEM = new Argument.ParsedArgument<IntentionalProblem>(Planner.PROBLEM.name, Planner.PROBLEM.abbreviation, IntentionalProblem.class){
		
		@Override
		protected IntentionalProblem getValue(Object object, ArgumentMap arguments){
			arguments.get(DOMAIN);
			return super.getValue(object, arguments);
		}
	};
	
	public IntentionalPlanner(String name){
		super(name);
	}
}
