package com.stephengware.java.planware;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.util.ImmutableSet;

public class Domain {

	public final String name;
	public final Universe universe;
	public final ImmutableSet<Operator> operators;
	public final ImmutableSet<AxiomTemplate> axioms;
	private final int hashCode;
	
	public Domain(String name, Universe universe, ImmutableSet<Operator> operators, ImmutableSet<AxiomTemplate> axioms){
		if(name == null)
			throw new FormatException("domain", "Name cannot be null.");
		this.name = name;
		if(universe == null)
			throw new FormatException("domain", "Universe cannot be null.");
		this.universe = universe;
		if(operators == null)
			operators = new ImmutableSet<Operator>(new Operator[0]);
		HashSet<String> operatorNames = new HashSet<>();
		for(int i=0; i<operators.length; i++){
			Operator operator = operators.get(i);
			if(operator == null)
				throw new FormatException("domain", "Operator " + (i + 1) + " cannot be null.");
			if(operatorNames.contains(operator.name))
				throw new FormatException("domain", "There cannot be two operators with the name \"" + operator.name + "\".");
			Object undefined = universe.getUndefinedObject(operator);
			if(undefined != null)
				throw new FormatException("domain", "Operator \"" + operator.name + "\" contains the element \"" + undefined + "\", which is not defined in this universe.");
		}
		this.operators = operators;
		if(axioms == null)
			axioms = new ImmutableSet<>(new AxiomTemplate[0]);
		for(int i=0; i<axioms.length; i++){
			if(axioms.get(i) == null)
				throw new FormatException("domain", "Axiom " + (i + 1) + " cannot be null.");
			Object undefined = universe.getUndefinedObject(axioms.get(i));
			if(undefined != null)
				throw new FormatException("domain", "Axiom " + (i + 1) + " contains the element \"" + undefined + "\", which is not defined in this universe.");
		}
		this.axioms = axioms;
		this.hashCode = name.hashCode() + universe.hashCode() + operators.hashCode() + axioms.hashCode();
	}
	
	public Domain(String name, Universe universe, Set<Operator> operators, Set<AxiomTemplate> axioms){
		this(name, universe, new ImmutableSet<Operator>(operators.toArray(new Operator[operators.size()])), new ImmutableSet<AxiomTemplate>(axioms.toArray(new AxiomTemplate[axioms.size()])));
	}
	
	public Domain(String name, Universe universe, Operator[] operators, AxiomTemplate[] axioms){
		this(name, universe, new ImmutableSet<Operator>(operators), new ImmutableSet<AxiomTemplate>(axioms));
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Domain){
			Domain otherDomain = (Domain) other;
			if(!testCompatibility(otherDomain) || !otherDomain.testCompatibility(this))
				return false;
			return name.equals(otherDomain.name) &&
				universe.equals(otherDomain.universe) &&
				operators.equals(otherDomain.operators) &&
				axioms.equals(otherDomain.axioms);
		}
		return false;
	}
	
	protected boolean testCompatibility(Domain other){
		return true;
	}
	
	public Operator getOperator(String name){
		for(Operator operator : operators)
			if(operator.name.equals(name))
				return operator;
		throw new IllegalArgumentException("This domain has no operator named \"" + name + "\".");
	}
	
	public AxiomTemplate getAxiomTemplate(int index){
		if(index >= 0 && index < axioms.length)
			return axioms.get(index);
		else
			throw new IllegalArgumentException("This domain has no axiom template " + index + ".");
	}
	
	public final <E extends Entity> Collection<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<E>();
		collect(entityType, collection);
		return collection;	
	}
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		for(Operator operator : operators)
			operator.collect(entityType, collection);
		for(AxiomTemplate axiom : axioms)
			axiom.collect(entityType, collection);
	}
	
	@SuppressWarnings("unchecked")
	public Domain substitute(Substitution substitution){
		boolean different = false;
		Universe universe = this.universe.substitute(substitution);
		if(universe != this.universe)
			different = true;
		ImmutableSet<Operator> operators = (ImmutableSet<Operator>) substituteOperators(substitution);
		if(operators != this.operators)
			different = true;
		ImmutableSet<AxiomTemplate> axioms = (ImmutableSet<AxiomTemplate>) substituteAxioms(substitution);
		if(axioms != this.axioms)
			different = true;
		if(different)
			return new Domain(name, universe, operators, axioms);
		else
			return this;
	}
	
	protected ImmutableSet<? extends Operator> substituteOperators(Substitution substitution){
		boolean different = false;
		Operator[] operators = new Operator[this.operators.length];
		for(int i=0; i<operators.length; i++){
			operators[i] = this.operators.get(i).substitute(substitution);
			if(operators[i] != this.operators.get(i))
				different = true;
		}
		if(different)
			return new ImmutableSet<>(operators);
		else
			return this.operators;
	}
	
	protected ImmutableSet<? extends AxiomTemplate> substituteAxioms(Substitution substitution){
		boolean different = false;
		AxiomTemplate[] axioms = new AxiomTemplate[this.axioms.length];
		for(int i=0; i<axioms.length; i++){
			axioms[i] = this.axioms.get(i).substitute(substitution);
			if(axioms[i] != this.axioms.get(i))
				different = true;
		}
		if(different)
			return new ImmutableSet<>(axioms);
		else
			return this.axioms;
	}
	
	@Override
	public String toString(){
		return "[Domain \"" + name + "\": " + operators.length + " operators, " + axioms.length + " axioms]";
	}
}
