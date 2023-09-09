package com.stephengware.java.planware;

import java.util.Collection;

import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.util.ImmutableArray;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionalStep extends Step {

	public final IntentionalOperator operator;
	public final ImmutableSet<Constant> agents;
	
	public IntentionalStep(IntentionalOperator operator, ImmutableArray<Entity> arguments, String name, Expression precondition, Expression effect, ImmutableSet<Constant> agents){
		super(operator, arguments, name, precondition, effect);
		this.operator = operator;
		if(agents == null)
			throw new FormatException("intentional step", "Agents cannot be null.");
		for(int i=0; i<agents.length; i++)
			if(agents.get(i) == null)
				throw new FormatException("intentional step", "Agent " + (i + 1) + " cannot be null.");
		this.agents = agents;
	}
	
	public IntentionalStep(IntentionalOperator operator, ImmutableArray<Entity> arguments, Expression precondition, Expression effect, ImmutableSet<Constant> agents){
		this(operator, arguments, operator.name, precondition, effect, agents);
	}
	
	@Override
	public boolean equals(Object other){
		if(super.equals(other))
			return agents.equals(((IntentionalStep) other).agents);
		else
			return false;
	}
	
	@Override
	protected boolean testCompatibility(Step other){
		return other instanceof IntentionalStep;
	}
	
	@Override
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		super.collect(entityType, collection);
		for(int i=0; i<agents.length; i++)
			agents.get(i).collect(entityType, collection);
	}
	
	@Override
	public IntentionalStep substitute(Substitution substitution){
		boolean different = false;
		ImmutableArray<Entity> arguments = substituteArguments(substitution);
		if(arguments != this.arguments)
			different = true;
		Expression precondition = this.precondition.substitute(substitution);
		if(precondition != this.precondition)
			different = true;
		Expression effect = this.effect.substitute(substitution);
		if(effect != this.effect)
			different = true;
		ImmutableSet<Constant> agents = substituteAgents(substitution);
		if(agents != this.agents)
			different = true;
		if(different)
			return new IntentionalStep(operator, arguments, precondition, effect, agents);
		else
			return this;
	}
	
	protected ImmutableSet<Constant> substituteAgents(Substitution substitution){
		boolean different = false;
		Constant[] characters = new Constant[this.agents.length];
		for(int i=0; i<characters.length; i++){
			characters[i] = substitution.substitute(this.agents.get(i), Constant.class);
			if(characters[i] != this.agents.get(i))
				different = true;
		}
		if(different)
			return new ImmutableSet<>(characters);
		else
			return this.agents;	
	}
}
