package com.stephengware.java.planware;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.util.ImmutableArray;

public class Step implements Comparable<Step> {

	public final Operator operator;
	public final ImmutableArray<Entity> arguments;
	public final String name;
	public final Expression precondition;
	public final Expression effect;
	protected final ImmutableArray<Clause> preconditionClauses;
	protected final ImmutableArray<Effect> effectLiterals;
	private final int hashCode;
	
	protected Step(Operator operator, ImmutableArray<Entity> arguments, String name, Expression precondition, Expression effect){
		this.operator = operator;
		this.arguments = arguments;
		if(name == null)
			throw new FormatException("step", "Name cannot be null.");
		this.name = name;
		this.precondition = precondition;
		this.effect = effect;
		this.preconditionClauses = new ImmutableArray<>(Utilities.getPreconditionClauses("precondition", precondition));
		this.effectLiterals = new ImmutableArray<>(Utilities.getEffectLiterals("effect", effect));
		this.hashCode = name.hashCode();
	}
	
	protected Step(Operator operator, ImmutableArray<Entity> arguments, Expression precondition, Expression effect){
		this(operator, arguments, operator.name, precondition, effect);
	}
	
	public Step(String name, Expression precondition, Expression effect){
		this(null, null, name, precondition, effect);
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Step){
			Step otherStep = (Step) other;
			if(!testCompatibility(otherStep) || !otherStep.testCompatibility(this))
				return false;
			if(operator == null){
				if(otherStep.operator != null)
					return false;
			}
			else{
				if(!operator.equals(otherStep.operator))
					return false;
			}
			if(arguments == null){
				if(otherStep.arguments != null)
					return false;
			}
			else{
				if(!arguments.equals(otherStep.arguments))
					return false;
			}
			return name.equals(otherStep.name) &&
				precondition.equals(otherStep.precondition) &&
				effect.equals(otherStep.effect);
		}
		return false;
	}
	
	protected boolean testCompatibility(Step other){
		return true;
	}
	
	public ImmutableArray<Clause> getPreconditionClauses(){
		return preconditionClauses;
	}
	
	public ImmutableArray<Effect> getEffectLiterals(){
		return effectLiterals;
	}
	
	@Override
	public int compareTo(Step other){
		return toString().compareTo(other.toString());
	}
	
	public <E extends Entity> Set<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<E>();
		collect(entityType, collection);
		return collection;
	}
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		precondition.collect(entityType, collection);
		effect.collect(entityType, collection);
	}
	
	public Step substitute(Substitution substitution){
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
		if(different)
			return new Step(operator, arguments, name, precondition, effect);
		else
			return this;
	}
	
	protected ImmutableArray<Entity> substituteArguments(Substitution substitution){
		if(this.arguments == null)
			return null;
		else{
			boolean different = false;
			Entity[] arguments = new Entity[this.arguments.length];
			for(int i=0; i<arguments.length; i++){
				arguments[i] = this.arguments.get(i).substitute(substitution);
				if(arguments[i] != this.arguments.get(i))
					different = true;
			}
			if(different)
				return new ImmutableArray<Entity>(arguments);
			else
				return this.arguments;
		}
	}
	
	@Override
	public String toString(){
		String str = "(" + name;
		for(int i=0; i<arguments.length; i++)
			str += " " + arguments.get(i);
		return str + ")";
	}
}
