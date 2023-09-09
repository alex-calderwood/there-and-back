package com.stephengware.java.planware;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.stephengware.java.planware.logic.ConditionalExpression;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.QuantifiedExpression;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.logic.Variable;
import com.stephengware.java.planware.util.ImmutableArray;

public class Operator {

	public final String name;
	public final ImmutableArray<Variable> parameters;
	public final Expression precondition;
	public final Expression effect;
	private final int hashCode;
	
	public Operator(String name, ImmutableArray<Variable> parameters, Expression precondition, Expression effect){
		// Name must not be null.
		if(name == null)
			throw new FormatException("operator", "Name cannot be null.");
		this.name = name;
		// Parameters
		if(parameters == null)
			parameters = new ImmutableArray<Variable>(new Variable[0]);
		for(int i=0; i<parameters.length; i++)
			if(parameters.get(i) == null)
				throw new FormatException("operator", "Parameter " + (i + 1) + " cannot be null.");
		HashSet<String> parameterNames = new HashSet<>();
		for(int i=0; i<parameters.length; i++){
			if(parameterNames.contains(parameters.get(i).name))
				throw new FormatException("operator", "Two parameters cannot have the same name \"" + parameters.get(i).name + "\".");
			parameterNames.add(parameters.get(i).name);			
		}
		this.parameters = parameters;
		// Precondition cannot contain non-parameter variables.
		if(precondition == null)
			precondition = Expression.TRUE;
		else{
			Variable nonParameter = findNonParameterVariable(precondition, this.parameters);
			if(nonParameter != null)
				throw new FormatException("operator", "The variable \"" + nonParameter + "\" is used in the precondition of operator \"" + name + "\" but is not a parameter.");
		}
		this.precondition = precondition;
		// Precondition cannot contain conditions.
		if(!precondition.collect(ConditionalExpression.class).isEmpty())
			throw new FormatException("operator", "Conditional effect used in precondition.");
		// Effect cannot be null.
		if(effect == null || effect == Expression.FALSE)
			throw new FormatException("operator", "Effect cannot be \"" + effect + "\".");
		// Effect cannot contain non-parameter variables.
		Variable nonParameter = findNonParameterVariable(effect, this.parameters);
		if(nonParameter != null)
			throw new FormatException("operator", "The variable \"" + nonParameter + "\" is used in the effect of operator \"" + name + "\" but is not a parameter.");
		// Effect must be deterministic.
		if(!effect.isImposable())
			throw new NonDeterministicException(effect);
		this.effect = effect;
		// Every parameter must be used.
		for(Variable parameter : parameters)
			if(!precondition.occurs(parameter) && !effect.occurs(parameter))
				throw new FormatException("operator", "The parameter \"" + parameter + "\" is not used.");
		// Hash Code
		this.hashCode = name.hashCode();
	}
	
	private final Variable findNonParameterVariable(Entity entity, ImmutableArray<Variable> parameters){
		if(entity instanceof Variable && !parameters.contains((Variable) entity))
			return (Variable) entity;
		if(entity instanceof QuantifiedExpression){
			Variable[] newParameters = new Variable[parameters.length + 1];
			System.arraycopy(parameters.toArray(), 0, newParameters, 1, parameters.length);
			newParameters[0] = ((QuantifiedExpression) entity).variable;
			parameters = new ImmutableArray<>(newParameters);
		}
		for(Iterator<? extends Entity> entities = entity.iterator(); entities.hasNext();){
			Variable variable = findNonParameterVariable(entities.next(), parameters);
			if(variable != null)
				return variable;
		}
		return null;
	}
	
	public Operator(String name, Variable[] parameters, Expression precondition, Expression effect){
		this(name, new ImmutableArray<Variable>(parameters), precondition, effect);
	}
	
	public Operator(String name, List<Variable> parameters, Expression precondition, Expression effect){
		this(name, parameters.toArray(new Variable[parameters.size()]), precondition, effect);
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Operator){
			Operator otherOperator = (Operator) other;
			if(!testCompatibility(otherOperator) || !otherOperator.testCompatibility(this))
				return false;
			return name.equals(otherOperator.name) &&
				parameters.equals(otherOperator.parameters) &&
				precondition.equals(otherOperator.precondition) &&
				effect.equals(otherOperator.effect);
		}
		return false;
	}
	
	protected boolean testCompatibility(Operator other){
		return true;
	}
	
	public <E extends Entity> Set<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<E>();
		collect(entityType, collection);
		return collection;
	}
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		for(int i=0; i<parameters.length; i++)
			parameters.get(i).collect(entityType, collection);
		precondition.collect(entityType, collection);
		effect.collect(entityType, collection);
	}
	
	public Operator substitute(Substitution substitution){
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
		if(different)
			return new Operator(name, parameters, precondition, effect);
		else
			return this;
	}
	
	protected ImmutableArray<Variable> substituteParameters(Substitution substitution){
		boolean different = false;
		Variable[] parameters = new Variable[this.parameters.length];
		for(int i=0; i<parameters.length; i++){
			parameters[i] = substitution.substitute(this.parameters.get(i), Variable.class);
			if(parameters[i] != this.parameters.get(i))
				different = true;
		}
		if(different)
			return new ImmutableArray<>(parameters);
		else
			return this.parameters;
	}
	
	@Override
	public String toString(){
		String str = "(" + name;
		for(Variable parameter : parameters)
			str += " " + parameter;
		return str + ")";
	}
}
