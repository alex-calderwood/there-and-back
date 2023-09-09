package com.stephengware.java.planware.ss;

import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.Set;
import java.util.TreeSet;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.ground.Grounder;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.util.ImmutableSet;

public class StateSpace {

	public final Problem problem;
	public final ImmutableSet<Literal> literals;
	public final ImmutableSet<Step> steps;
	public final ImmutableSet<Axiom> axioms;
	
	public StateSpace(Problem problem, ImmutableSet<Literal> literals, ImmutableSet<Step> steps, ImmutableSet<Axiom> axioms){
		if(problem == null)
			throw new FormatException("state space", "Problem cannot be null.");
		this.problem = problem;
		if(literals == null)
			literals = new ImmutableSet<Literal>(new Literal[0]);
		for(int i=0; i<literals.length; i++){
			Literal literal = literals.get(i);
			if(literal == null)
				throw new FormatException("state space", "Literal " + (i + 1) + " cannot be null.");
			if(!literal.isGround())
				throw new FormatException("state space", "The literal \"" + literal + "\" is not ground.");
		}
		this.literals = removeTrueAndFalseLiterals(literals);
		if(steps == null)
			steps = new ImmutableSet<Step>(new Step[0]);
		for(int i=0; i<steps.length; i++)
			if(steps.get(i) == null)
				throw new FormatException("state space", "Step " + (i + 1) + " cannot be null.");
		this.steps = removeStepsWithFalsePreconditions(steps);
		if(axioms == null)
			axioms = new ImmutableSet<Axiom>(new Axiom[0]);
		for(int i=0; i<axioms.length; i++)
			if(axioms.get(i) == null)
				throw new FormatException("state space", "Axiom " + (i + 1) + " cannot be null.");
		this.axioms = removeAxiomsWithFalsePreconditions(axioms);
	}
	
	public StateSpace(Problem problem, Set<Literal> literals, Set<Step> steps, Set<Axiom> axioms){
		this(problem, new ImmutableSet<Literal>(literals, Literal.class), new ImmutableSet<Step>(steps, Step.class), new ImmutableSet<Axiom>(axioms, Axiom.class));
	}
	
	private StateSpace(Problem problem, Set<Step> steps, Set<Axiom> axioms, Grounder<? extends Problem> grounder){
		this(problem, collectLiterals(steps, axioms, grounder.problem), steps, axioms);
	}
	
	public StateSpace(Grounder<? extends Problem> grounder){
		this(grounder.problem, groundOperators(grounder), groundAxioms(grounder), grounder);
	}
	
	public StateSpace(Problem problem){
		this(new Grounder<Problem>(problem));
	}
	
	private static final ImmutableSet<Literal> removeTrueAndFalseLiterals(ImmutableSet<Literal> literals){
		LinkedList<Literal> filtered = new LinkedList<>();
		for(Literal literal : literals)
			if(literal != Expression.TRUE && literal != Expression.FALSE)
				filtered.add(literal);
		if(filtered.size() == literals.length)
			return literals;
		else
			return new ImmutableSet<>(filtered.toArray(new Literal[filtered.size()]));
	}
	
	private static final ImmutableSet<Step> removeStepsWithFalsePreconditions(ImmutableSet<Step> steps){
		LinkedList<Step> filtered = new LinkedList<>();
		for(Step step : steps)
			if(step.precondition != Expression.FALSE)
				filtered.add(step);
		if(filtered.size() == steps.length)
			return steps;
		else
			return new ImmutableSet<Step>(filtered.toArray(new Step[filtered.size()]));
	}
	
	private static final ImmutableSet<Axiom> removeAxiomsWithFalsePreconditions(ImmutableSet<Axiom> axioms){
		LinkedList<Axiom> filtered = new LinkedList<>();
		for(Axiom axiom : axioms)
			if(axiom.context != Expression.FALSE)
				filtered.add(axiom);
		if(filtered.size() == axioms.length)
			return axioms;
		else
			return new ImmutableSet<Axiom>(filtered.toArray(new Axiom[filtered.size()]));
	}
	
	private static final Set<Literal> collectLiterals(Set<Step> steps, Set<Axiom> axioms, Problem problem){
		TreeSet<Literal> literals = new TreeSet<>();
		problem.initialState.collect(Literal.class, literals);
		problem.goal.collect(Literal.class, literals);
		for(Step step : steps)
			step.collect(Literal.class, literals);
		for(Axiom axiom : axioms)
			axiom.collect(Literal.class, literals);
		return literals;
	}
	
	private static final Set<Step> groundOperators(Grounder<? extends Problem> grounder){
		LinkedHashSet<Step> steps = new LinkedHashSet<>();
		for(Operator operator : grounder.problem.domain.operators)
			steps.addAll(grounder.ground(operator, Step.class));
		return steps;
	}
	
	private static final Set<Axiom> groundAxioms(Grounder<? extends Problem> grounder){
		LinkedHashSet<Axiom> axioms = new LinkedHashSet<>();
		for(AxiomTemplate template : grounder.problem.domain.axioms)
			axioms.addAll(grounder.ground(template, Axiom.class));
		return axioms;
	}
	
	public <E extends Entity> Collection<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<>();
		collect(entityType, collection);
		return collection;
	}
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		problem.getInitialState().collect(entityType, collection);
		problem.getGoal().collect(entityType, collection);
		for(Literal literal : literals)
			literal.collect(entityType, collection);
		for(Step step : steps)
			step.collect(entityType, collection);
		for(Axiom axiom : axioms)
			axiom.collect(entityType, collection);
	}
	
	public StateSpace substitute(Substitution substitution){
		boolean different = false;
		Problem problem = this.problem.substitute(substitution);
		if(problem != this.problem)
			different = true;
		ImmutableSet<Literal> literals = substituteLiterals(substitution);
		if(literals != this.literals)
			different = true;
		ImmutableSet<Step> steps = substituteSteps(substitution);
		if(steps != this.steps)
			different = true;
		ImmutableSet<Axiom> axioms = substituteAxioms(substitution);
		if(axioms != this.axioms)
			different = true;
		if(different)
			return new StateSpace(problem, literals, steps, axioms);
		else
			return this;
	}
	
	protected ImmutableSet<Literal> substituteLiterals(Substitution substitution){
		boolean different = false;
		Literal[] literals = new Literal[this.literals.length];
		for(int i=0; i<literals.length; i++){
			literals[i] = substitution.substitute(this.literals.get(i), Literal.class);
			if(literals[i] != this.literals.get(i))
				different = true;
		}
		if(different)
			return new ImmutableSet<Literal>(literals);
		else
			return this.literals;
	}
	
	protected ImmutableSet<Step> substituteSteps(Substitution substitution){
		boolean different = false;
		Step[] steps = new Step[this.steps.length];
		for(int i=0; i<steps.length; i++){
			steps[i] = this.steps.get(i).substitute(substitution);
			if(steps[i] != this.steps.get(i))
				different = true;
		}
		if(different)
			return new ImmutableSet<Step>(steps);
		else
			return this.steps;
	}
	
	protected ImmutableSet<Axiom> substituteAxioms(Substitution substitution){
		boolean different = false;
		Axiom[] axioms = new Axiom[this.axioms.length];
		for(int i=0; i<axioms.length; i++){
			axioms[i] = this.axioms.get(i).substitute(substitution);
			if(axioms[i] != this.axioms.get(i))
				different = true;
		}
		if(different)
			return new ImmutableSet<Axiom>(axioms);
		else
			return this.axioms;
	}
		
	@Override
	public String toString(){
		return "[State Space: " + literals.length + " literals, " + steps.length + " steps, " + axioms.length + " axioms]";
	}
}
