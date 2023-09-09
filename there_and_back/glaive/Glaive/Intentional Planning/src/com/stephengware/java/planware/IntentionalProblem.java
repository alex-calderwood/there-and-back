package com.stephengware.java.planware;

import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.util.ImmutableArray;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionalProblem extends Problem {

	public final IntentionalDomain domain;
	
	public IntentionalProblem(String name, IntentionalDomain domain, Universe universe, Expression initialState, Expression goal){
		super(name, domain, universe, initialState, goal);
		this.domain = domain;
	}
	
	@Override
	protected boolean testCompatibility(Problem other){
		return other instanceof IntentionalProblem;
	}
	
	@Override
	public IntentionalProblem substitute(Substitution substitution){
		boolean different = false;
		IntentionalDomain domain = this.domain.substitute(substitution);
		if(domain != this.domain)
			different = true;
		Universe universe = this.universe.substitute(substitution);
		if(universe != this.universe)
			different = true;
		Expression initialState = this.initialState.substitute(substitution);
		if(initialState != this.initialState)
			different = true;
		Expression goal = this.goal.substitute(substitution);
		if(goal != this.goal)
			different = true;
		if(different)
			return new IntentionalProblem(name, domain, universe, initialState, goal);
		else
			return this;
	}
	
	@Override
	public IntentionalStep makeStep(String operatorName, Entity...arguments){
		IntentionalOperator operator = domain.getOperator(operatorName);
		Substitution substitution = getSubstitution(operator.parameters, arguments);
		Constant[] agents = new Constant[operator.agents.length];
		for(int i=0; i<agents.length; i++)
			agents[i] = substitution.substitute(operator.agents.get(i), Constant.class);
		return new IntentionalStep(operator, new ImmutableArray<Entity>(arguments), operator.precondition.substitute(substitution), operator.effect.substitute(substitution), new ImmutableSet<>(agents));
	}
	
	/*
	public IntentionalStep makeStep(Step step){
		if(step instanceof IntentionalStep)
			return (IntentionalStep) step;
		else if(step.operator != null)
			return makeStep(step.operator, step.arguments.toArray());
		else
			throw new IllegalArgumentException("The step \"" + step + "\" could not be converted to " + IntentionalStep.class.getSimpleName() + ".");
	}
	*/
}
