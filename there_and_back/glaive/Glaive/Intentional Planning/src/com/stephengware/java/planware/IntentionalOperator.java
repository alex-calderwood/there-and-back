package com.stephengware.java.planware;

import java.util.Collection;

import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.logic.Term;
import com.stephengware.java.planware.logic.Variable;
import com.stephengware.java.planware.util.ImmutableArray;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionalOperator extends Operator {

	public final ImmutableSet<Term> agents;
	
	public IntentionalOperator(String name, ImmutableArray<Variable> parameters, Expression precondition, Expression effect, ImmutableSet<Term> agents){
		super(name, parameters, precondition, effect);
		if(agents == null)
			throw new FormatException("intentional operator", "Characters cannot be null.");
		for(int i=0; i<agents.length; i++){
			if(agents.get(i) == null)
				throw new FormatException("intentional operator", "Agent " + (i + 1) + " cannot be null.");
			if(agents.get(i) instanceof Variable && !parameters.contains((Variable) agents.get(i)))
				throw new FormatException("intentional operator", "The variable " + agents.get(i) + " is named as an agent but is not a parameter.");
		}
		this.agents = agents;
	}
	
	public IntentionalOperator(String name, Variable[] parameters, Expression precondition, Expression effect, Term[] agents){
		this(name, new ImmutableArray<Variable>(parameters), precondition, effect, new ImmutableSet<Term>(agents));
	}
	
	@Override
	public boolean equals(Object other){
		if(super.equals(other))
			return agents.equals(((IntentionalOperator) other).agents);
		else
			return false;
	}
	
	@Override
	protected boolean testCompatibility(Operator other){
		return other instanceof IntentionalOperator;
	}
	
	@Override
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		super.collect(entityType, collection);
		for(int i=0; i<agents.length; i++)
			agents.get(i).collect(entityType, collection);
	}
	
	@Override
	public IntentionalOperator substitute(Substitution substitution){
		boolean different = true;
		ImmutableArray<Variable> parameters = substituteParameters(substitution);
		if(parameters != this.parameters)
			different = true;
		Expression precondition = this.precondition.substitute(substitution);
		if(precondition != this.precondition)
			different = true;
		Expression effect = this.effect.substitute(substitution);
		if(effect != this.effect)
			different = true;
		ImmutableSet<Term> agents = substituteAgents(substitution);
		if(agents != this.agents)
			different = true;
		if(different)
			return new IntentionalOperator(name, parameters, precondition, effect, agents);
		else
			return this;
	}
	
	protected ImmutableSet<Term> substituteAgents(Substitution substitution){
		boolean different = true;
		Term[] agents = new Term[this.agents.length];
		for(int i=0; i<agents.length; i++){
			agents[i] = this.agents.get(i).substitute(substitution);
			if(agents[i] != this.agents.get(i))
				different = true;
		}
		if(different)
			return new ImmutableSet<Term>(agents);
		else
			return this.agents;
	}
}
