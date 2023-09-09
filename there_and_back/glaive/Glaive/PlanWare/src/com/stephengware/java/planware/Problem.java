package com.stephengware.java.planware;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.HashSubstitution;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.logic.Variable;
import com.stephengware.java.planware.util.ImmutableArray;

public class Problem {

	public final String name;
	public final Domain domain;
	public final Universe universe;
	public final Expression initialState;
	private final Expression groundInitialState;
	public final Expression goal;
	private final Expression groundGoal;
	private final int hashCode;
	
	public Problem(String name, Domain domain, Universe universe, Expression initialState, Expression goal){
		if(name == null)
			throw new FormatException("problem", "Name cannot be null.");
		this.name = name;
		if(domain == null)
			throw new FormatException("problem", "Domain cannot be null.");
		this.domain = domain;
		if(universe == null)
			throw new FormatException("problem", "Universe cannot be null.");
		if(!universe.subsumes(domain.universe))
			throw new FormatException("problem", "Universe must contain all elements of the domain's universe.");
		if(universe.taxonomy != domain.universe.taxonomy)
			throw new FormatException("problem", "Universe cannot define a different taxonomy.");
		if(!universe.predicates.equals(domain.universe.predicates))
			throw new FormatException("problem", "Universe cannot define new predicates.");
		if(!universe.modalities.equals(domain.universe.modalities))
			throw new FormatException("problem", "Universe cannot define new modalities.");
		this.universe = universe;
		HashSubstitution universeSubstitution = new HashSubstitution(universe);
		if(initialState == null)
			initialState = Expression.TRUE;
		this.initialState = initialState;
		this.groundInitialState = initialState.substitute(universeSubstitution);
		if(goal == null)
			goal = Expression.TRUE;
		this.goal = goal;
		this.groundGoal = goal.substitute(universeSubstitution);
		this.hashCode = name.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Problem){
			Problem otherProblem = (Problem) other;
			if(!testCompatibility(otherProblem) || !otherProblem.testCompatibility(this))
				return false;
			return name.equals(otherProblem.name) &&
				domain.equals(otherProblem.domain) &&
				universe.equals(otherProblem.universe) &&
				initialState.equals(otherProblem.initialState) &&
				goal.equals(otherProblem.goal);
		}
		return false;
	}
	
	protected boolean testCompatibility(Problem other){
		return true;
	}
	
	public Expression getInitialState(){
		return groundInitialState;
	}
	
	public Expression getGoal(){
		return groundGoal;
	}
	
	public Step makeStep(String operatorName, Entity...arguments){
		Operator operator = domain.getOperator(operatorName);
		Substitution substitution = getSubstitution(operator.parameters, arguments);
		return new Step(operator, new ImmutableArray<Entity>(arguments), operator.precondition.substitute(substitution), operator.effect.substitute(substitution));
	}
	
	public Axiom makeAxiom(int axiomIndex, Entity...arguments){
		AxiomTemplate template = domain.getAxiomTemplate(axiomIndex);
		Substitution substitution = getSubstitution(template.parameters, arguments);
		return new Axiom(template.context.substitute(substitution), template.implies.substitute(substitution));
	}
	
	protected Substitution getSubstitution(ImmutableArray<Variable> parameters, Entity[] arguments){
		if(parameters.length != arguments.length)
			throw new IllegalArgumentException("Expected " + parameters.length + " arguments, but " + arguments.length + " were given.");
		HashSubstitution substitution = new HashSubstitution(universe);
		for(int i=0; i<arguments.length; i++){
			if(!universe.defines(arguments[i]))
				throw new IllegalArgumentException("The " + arguments[i].getDescription() + " \"" + arguments[i] + "\" is not defined in this universe.");
			if(!parameters.get(i).subsumes(arguments[i], universe.taxonomy))
				throw new IllegalArgumentException("The " + arguments[i].getDescription() + " \"" + arguments[i] + "\" is not a valid substitution for the parameter \"" + parameters.get(i) + "\".");
			substitution.replace(parameters.get(i), arguments[i]);
		}
		return substitution;
	}
	
	public final <E extends Entity> Set<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<E>();
		collect(entityType, collection);
		return collection;
	}
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		domain.collect(entityType, collection);
		universe.collect(entityType, collection);
		initialState.collect(entityType, collection);
		goal.collect(entityType, collection);
	}
	
	public Problem substitute(Substitution substitution){
		boolean different = false;
		Domain domain = this.domain.substitute(substitution);
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
			return new Problem(name, domain, universe, initialState, goal);
		else
			return this;
	}
	
	@Override
	public String toString(){
		return "[Problem \"" + name + "\" in Domain \"" + domain.name + "\"]";
	}
}
