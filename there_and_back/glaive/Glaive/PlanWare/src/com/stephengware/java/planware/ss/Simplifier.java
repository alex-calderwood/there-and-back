package com.stephengware.java.planware.ss;

import java.util.LinkedHashSet;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.util.ImmutableSet;

public class Simplifier {
	
	public static StateSpace removeUnusedElements(StateSpace space){
		MonotonicallyIncreasingState state = expandFromInitialState(space);
		return new StateSpace(space.problem, removeUnusedLiterals(space, state), removeUnusedSteps(space, state), removeUnusedAxioms(space, state));
	}
	
	public static StateSpace removeUnusedLiterals(StateSpace space, Problem problem){
		return new StateSpace(space.problem, removeUnusedLiterals(space, expandFromInitialState(space)), space.steps, space.axioms);
	}

	protected static ImmutableSet<Literal> removeUnusedLiterals(StateSpace space, MonotonicallyIncreasingState state){
		LinkedHashSet<Literal> literals = new LinkedHashSet<>(space.literals.size());
		for(Literal literal : space.literals)
			if(state.literals.contains(literal))
				literals.add(literal);
		return new ImmutableSet<>(literals, Literal.class); 
	}
	
	public static StateSpace removeUnusedSteps(StateSpace space, Problem problem){
		return new StateSpace(space.problem, space.literals, removeUnusedSteps(space, expandFromInitialState(space)), space.axioms);
	}
	
	protected static ImmutableSet<Step> removeUnusedSteps(StateSpace space, MonotonicallyIncreasingState state){
		LinkedHashSet<Step> steps = new LinkedHashSet<>(space.steps.size());
		for(Step step : space.steps)
			if(state.steps.contains(step))
				steps.add(step);
		return new ImmutableSet<>(steps, Step.class); 
	}
	
	public static StateSpace removeUnusedAxioms(StateSpace space, Problem problem){
		return new StateSpace(space.problem, space.literals, space.steps, removeUnusedAxioms(space, expandFromInitialState(space)));
	}
	
	protected static ImmutableSet<Axiom> removeUnusedAxioms(StateSpace space, MonotonicallyIncreasingState state){
		LinkedHashSet<Axiom> axioms = new LinkedHashSet<>(space.axioms.size());
		for(Axiom axiom : space.axioms)
			if(state.axioms.contains(axiom))
				axioms.add(axiom);
		return new ImmutableSet<>(axioms, Axiom.class);
	}
	
	protected static MonotonicallyIncreasingState expandFromInitialState(StateSpace space){
		MonotonicallyIncreasingState state = new MonotonicallyIncreasingState();
		state.impose(space.problem.initialState);
		boolean changed = true;
		while(changed){
			changed = false;
			for(Step step : space.steps)
				if(state.isTrue(step.precondition))
					if(state.execute(step))
						changed = true;
			for(Axiom axiom : space.axioms)
				if(state.isTrue(axiom.context))
					if(state.apply(axiom))
						changed = true;
		}
		return state;
	}
}
