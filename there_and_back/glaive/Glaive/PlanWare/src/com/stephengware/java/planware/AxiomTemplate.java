package com.stephengware.java.planware;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.QuantifiedExpression;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.logic.Variable;
import com.stephengware.java.planware.util.ImmutableArray;

public class AxiomTemplate {

	public final ImmutableArray<Variable> parameters;
	public final Expression context;
	public final Expression implies;
	private final int hashCode;
	
	public AxiomTemplate(ImmutableArray<Variable> parameters, Expression context, Expression implies){
		// Parameters
		if(parameters == null)
			parameters = new ImmutableArray<Variable>(new Variable[0]);
		for(int i=0; i<parameters.length; i++)
			if(parameters.get(i) == null)
				throw new FormatException("axiom template", "Parameter " + (i + 1) + " cannot be null.");
		this.parameters = parameters;
		// Context cannot contain non-parameter variables.
		HashSet<Variable> parameterSet = new HashSet<>();
		for(Variable parameter : parameters)
			parameterSet.add(parameter);
		if(context == null)
			context = Expression.TRUE;
		else{
			Variable nonParameter = findNonParameterVariable(context, parameterSet);
			if(nonParameter != null)
				throw new FormatException("axiom template", "The variable \"" + nonParameter + "\" is used in the context of an axiom but is not a parameter.");
		}
		this.context = context;
		// Implies cannot contain non-parameter variables
		if(implies == null)
			implies = Expression.TRUE;
		else{
			Variable nonParameter = findNonParameterVariable(implies, parameterSet);
			if(nonParameter != null)
				throw new FormatException("axiom template", "The variable \"" + nonParameter + "\" is used in the implies clause of an axiom but is not a parameter.");
		}
		this.implies = implies;
		// Every parameter must be used.
		for(Variable parameter : parameters)
			if(!context.occurs(parameter) && !implies.occurs(parameter))
				throw new FormatException("axiom template", "The parameter \"" + parameter + "\" is not used.");
		// Hash code
		int hc = context.hashCode() + implies.hashCode();
		for(Variable parameter : parameters)
			hc += parameter.hashCode();
		this.hashCode = hc;
	}
	
	@SuppressWarnings("unchecked")
	private final Variable findNonParameterVariable(Entity entity, HashSet<Variable> parameters){
		if(entity instanceof Variable && !parameters.contains(entity))
			return (Variable) entity;
		if(entity instanceof QuantifiedExpression){
			parameters = (HashSet<Variable>) parameters.clone();
			parameters.add(((QuantifiedExpression) entity).variable);
		}
		Iterator<? extends Entity> entities = entity.iterator();
		while(entities.hasNext()){
			Variable variable = findNonParameterVariable(entities.next(), parameters);
			if(variable != null)
				return variable;
		}
		return null;
	}
	
	public AxiomTemplate(Variable[] parameters, Expression context, Expression implies){
		this(new ImmutableArray<Variable>(parameters), context, implies);
	}
	
	public AxiomTemplate(List<Variable> parameters, Expression context, Expression implies){
		this(new ImmutableArray<Variable>(parameters.toArray(new Variable[parameters.size()])), context, implies);
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof AxiomTemplate){
			AxiomTemplate otherAxiom = (AxiomTemplate) other;
			if(!testCompatibility(otherAxiom) || !otherAxiom.testCompatibility(this))
				return false;
			if(parameters.length != otherAxiom.parameters.length)
				return false;
			for(int i=0; i<parameters.length; i++)
				if(!parameters.get(i).equals(otherAxiom.parameters.get(i)))
					return false;
			return context.equals(otherAxiom.context) && implies.equals(otherAxiom.implies);
		}
		return false;
	}
	
	protected boolean testCompatibility(AxiomTemplate other){
		return true;
	}
	
	public <E extends Entity> Set<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<E>();
		collect(entityType, collection);
		return collection;
	}
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		for(Variable parameter : parameters)
			parameter.collect(entityType, collection);
		context.collect(entityType, collection);
		implies.collect(entityType, collection);
	}
	
	public AxiomTemplate substitute(Substitution substitution){
		boolean different = false;
		ImmutableArray<Variable> substitutedParameters = substituteParameters(substitution);
		if(substitutedParameters != parameters)
			different = true;
		Expression substitutedContext = context.substitute(substitution);
		if(context != substitutedContext)
			different = true;
		Expression substitutedImplies = implies.substitute(substitution);
		if(implies != substitutedImplies)
			different = true;
		if(different)
			return new AxiomTemplate(substitutedParameters, substitutedContext, substitutedImplies);
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
		String str = "(:axiom ";
		if(parameters.length > 0){
			str += ":vars (";
			str += parameters.get(0);
			for(int i=1; i<parameters.length; i++)
				str += " " + parameters.get(i);
			str += ") ";
		}
		return str + ":context " + context + " :implies " + implies + ")";
	}
}
