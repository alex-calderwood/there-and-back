package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.util.ImmutableArray;

public class Predication extends ExpressionObject implements Literal {
	
	public final String predicate;
	public final ImmutableArray<Term> terms;
	private final int hashCode;
	private final boolean isGround;
	
	public Predication(String predicate, Term...terms){
		if(predicate == null)
			throw new FormatException(getDescription(), "Predicate cannot be null.");
		for(int i=0; i<terms.length; i++)
			if(terms[i] == null)
				throw new FormatException(getDescription(), "Term " + (i + 1) + " cannot be null.");
		this.predicate = predicate.intern();
		this.terms = new ImmutableArray<Term>(terms);
		int hc = predicate.hashCode();
		for(Term term : terms)
			hc = 31 * hc + term.hashCode();
		this.hashCode = hc;
		boolean ground = true;
		for(int i=0; i<terms.length; i++)
			if(!terms[i].isGround())
				ground = false;
		this.isGround = ground;
	}
	
	public Predication(String predicate, List<Term> terms){
		this(predicate, terms.toArray(new Term[terms.size()]));
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Predication){
			Predication otherPredication = (Predication) other;
			if(!testCompatibility(otherPredication) || !otherPredication.testCompatibility(this))
				return false;
			if(predicate != otherPredication.predicate || terms.length != otherPredication.terms.length)
				return false;
			for(int i=0; i<terms.length; i++)
				if(!terms.get(i).equals(otherPredication.terms.get(i)))
					return false;
			return true;
		}
		return false;
	}
	
	protected boolean testCompatibility(Predication other){
		return true;
	}
	
	@Override
	public Iterator<? extends Term> iterator(){
		return terms.iterator();
	}
	
	@Override
	public boolean isGround(){
		return isGround;
	}
	
	@Override
	public boolean occurs(Entity entity){
		if(equals(entity))
			return true;
		for(int i=0; i<terms.length; i++)
			if(terms.get(i).occurs(entity))
				return true;
		return false;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
		for(int i=0; i<terms.length; i++)
			terms.get(i).collect(entityType, collection);
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof Predication){
			Predication otherPredication = (Predication) other;
			if(predicate != otherPredication.predicate || terms.length != otherPredication.terms.length)
				return false;
			for(int i=0; i<terms.length; i++)
				if(!terms.get(i).subsumes(otherPredication.terms.get(i), taxonomy))
					return false;
			return true;
		}
		return false;
	}
	
	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(substituted != this)
			return substituted;
		for(int i=0; i<terms.length; i++){
			Term substitutedTerm = terms.get(i).substitute(substitution);
			if(substitutedTerm != terms.get(i)){
				Term[] substitutedTerms = new Term[terms.length];
				for(int j=0; j<i; j++)
					substitutedTerms[j] = terms.get(j);
				substitutedTerms[i] = substitutedTerm;
				for(int j=i+1; j<terms.length; j++)
					substitutedTerms[j] = terms.get(j).substitute(substitution);
				return new Predication(predicate, substitutedTerms).substitute(substitution);
			}
		}
		return this;
	}
	
	@Override
	public boolean isTestable(){
		return true;
	}
	
	@Override
	public boolean test(State state){
		return state.isTrue(this);
	}
	
	@Override
	public boolean isImposable(){
		return true;
	}
	
	@Override
	public boolean impose(State state){
		return state.impose(this);
	}
	
	private NegatedLiteral negation = null;
	
	@Override
	public NegatedLiteral negate(){
		if(negation == null)
			negation = new NegatedLiteral(this);
		return negation;
	}

	@Override
	public Expression toCNF(){
		return this;
	}

	@Override
	public Expression toDNF(){
		return this;
	}
	
	@Override
	public String toString(){
		String str = "(" + predicate;
		for(Term term : terms)
			str += " " + term;
		return str + ")";
	}
	
	@Override
	public String getDescription(){
		return "predication";
	}
}
