package com.stephengware.java.planware;

public abstract class IntentionalPlan extends Plan {

	public final IntentionalProblem problem;
	
	protected IntentionalPlan(IntentionalPlan plan){
		super(plan.name, plan.problem);
		this.problem = plan.problem;
	}
	
	public IntentionalPlan(String name, IntentionalProblem problem){
		super(name, problem);
		this.problem = problem;
	}

	@Override
	public abstract Iterable<? extends IntentionalStep> steps();

	@Override
	public abstract IntentionalPlan clone();
}
