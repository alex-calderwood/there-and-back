package com.stephengware.java.planware;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.util.ImmutableArray;

public class Axiom implements Comparable<Axiom> {

	public final Expression context;
	public final Expression implies;
	protected final ImmutableArray<Clause> preconditionClauses;
	protected final ImmutableArray<Effect> effectLiterals;
	private final int hashCode;
	
	public Axiom(Expression context, Expression implies){
		this.context = context;
		this.implies = implies;
		this.preconditionClauses = new ImmutableArray<>(Utilities.getPreconditionClauses("context", context));
		this.effectLiterals = new ImmutableArray<>(Utilities.getEffectLiterals("implies", implies));
		this.hashCode = context.hashCode() + implies.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Axiom){
			Axiom otherAxiom = (Axiom) other;
			if(!testCompatibility(otherAxiom) || !otherAxiom.testCompatibility(this))
				return false;
			return context.equals(otherAxiom.context) && implies.equals(otherAxiom.implies);
		}
		return false;
	}
	
	protected boolean testCompatibility(Axiom other){
		return true;
	}
	
	@Override
	public int compareTo(Axiom other){
		return toString().compareTo(other.toString());
	}
	
	public ImmutableArray<Clause> getPreconditionClauses(){
		return preconditionClauses;
	}
	
	public ImmutableArray<Effect> getEffectLiterals(){
		return effectLiterals;
	}
	
	public <E extends Entity> Set<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<E>();
		collect(entityType, collection);
		return collection;
	}
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		context.collect(entityType, collection);
		implies.collect(entityType, collection);
	}
	
	public Axiom substitute(Substitution substitution){
		boolean different = false;
		Expression substitutedContext = context.substitute(substitution);
		if(context != substitutedContext)
			different = true;
		Expression substitutedImplies = implies.substitute(substitution);
		if(implies != substitutedImplies)
			different = true;
		if(different)
			return new Axiom(substitutedContext, substitutedImplies);
		else
			return this;
	}
	
	@Override
	public String toString(){
		return "(:axiom :context " + context + " :implies " + implies + ")";
	}
}
