package com.stephengware.java.planware.ss;

import java.util.HashSet;
import java.util.Set;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.ground.Grounder;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionalStateSpace extends StateSpace {

	public final IntentionalProblem problem;
	public final ImmutableSet<IntentionalStep> steps;
	public final ImmutableSet<Constant> agents;
	
	@SuppressWarnings("unchecked")
	public IntentionalStateSpace(IntentionalProblem problem, ImmutableSet<Literal> literals, ImmutableSet<IntentionalStep> steps, ImmutableSet<Axiom> axioms){
		super(problem, literals, ((ImmutableSet<Step>) (ImmutableSet<?>) steps), axioms);
		this.problem = problem;
		this.steps = steps;
		this.agents = getAgents(steps);
	}
	
	private static final ImmutableSet<Constant> getAgents(ImmutableSet<IntentionalStep> steps){
		HashSet<Constant> agents = new HashSet<>();
		for(IntentionalStep step : steps)
			for(Constant agent : step.agents)
				agents.add(agent);
		return new ImmutableSet<>(agents, Constant.class);
	}
	
	public IntentionalStateSpace(IntentionalProblem problem, Set<Literal> literals, Set<IntentionalStep> steps, Set<Axiom> axioms){
		this(problem, new ImmutableSet<Literal>(literals, Literal.class), new ImmutableSet<IntentionalStep>(steps, IntentionalStep.class), new ImmutableSet<Axiom>(axioms, Axiom.class));
	}
	
	@SuppressWarnings("unchecked")
	public IntentionalStateSpace(Grounder<? extends IntentionalProblem> grounder){
		super(grounder);
		this.problem = (IntentionalProblem) super.problem;
		this.steps = (ImmutableSet<IntentionalStep>) (ImmutableSet<?>) super.steps;
		this.agents = getAgents(steps);
	}
	
	public IntentionalStateSpace(IntentionalProblem problem){
		this(new Grounder<IntentionalProblem>(problem));
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public IntentionalStateSpace substitute(Substitution substitution){
		boolean different = false;
		ImmutableSet<Literal> literals = substituteLiterals(substitution);
		if(literals != this.literals)
			different = true;
		ImmutableSet<IntentionalStep> steps = (ImmutableSet<IntentionalStep>) (ImmutableSet<?>) substituteSteps(substitution);
		if(steps != this.steps)
			different = true;
		ImmutableSet<Axiom> axioms = substituteAxioms(substitution);
		if(axioms != this.axioms)
			different = true;
		if(different)
			return new IntentionalStateSpace(problem, literals, steps, axioms);
		else
			return this;
	}
}
