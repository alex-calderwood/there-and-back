package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.Iterator;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.util.ArrayIterator;

public class Negation extends BooleanExpression {
	
	protected static final String NEGATION_PREDICATE = "not";
	
	public final Expression argument;
	private final int hashCode;
	
	public Negation(Expression argument){
		super(NEGATION_PREDICATE);
		if(argument == null)
			throw new FormatException(getDescription(), "Argument cannot be null.");
		this.argument = argument;
		this.hashCode = NEGATION_PREDICATE.hashCode() + argument.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Negation){
			Negation otherNegation = (Negation) other;
			if(!testCompatibility(otherNegation) || !otherNegation.testCompatibility(this))
				return false;
			return argument.equals(otherNegation.argument);
		}
		return false;
	}
	
	protected boolean testCompatibility(Negation other){
		return true;
	}
	
	@Override
	public int compareTo(Entity other){
		if(other instanceof Negation)
			return argument.compareTo(((Negation) other).argument);
		else{
			int compare = argument.compareTo(other);
			if(compare == 0)
				return 1;
			else
				return compare;
		}
	}
	
	@Override
	public Iterator<? extends Expression> iterator(){
		return new ArrayIterator<Expression>(argument);
	}
	
	@Override
	public boolean isGround(){
		return argument.isGround();
	}
	
	@Override
	public boolean occurs(Entity entity){
		return equals(entity) || argument.occurs(entity);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
		argument.collect(entityType, collection);
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof Negation)
			return argument.subsumes(((Negation) other).argument, taxonomy);
		return false;
	}
	
	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(substituted != this)
			return substituted;
		Expression substitutedArgument = argument.substitute(substitution);
		if(substitutedArgument == TRUE)
			return FALSE.substitute(substitution);
		else if(substitutedArgument == FALSE)
			return TRUE.substitute(substitution);
		else if(substitutedArgument instanceof Literal)
			return new NegatedLiteral((Literal) substitutedArgument).substitute(substitution);
		else if(substitutedArgument == argument)
			return this;
		else
			return new Negation(substitutedArgument).substitute(substitution);
	}

	@Override
	public boolean isTestable(){
		return argument.negate().isTestable();
	}
	
	@Override
	public boolean test(State state){
		return argument.negate().test(state);
	}
	
	@Override
	public boolean isImposable(){
		return argument.negate().isImposable();
	}
	
	@Override
	public boolean impose(State state){
		return argument.negate().impose(state);
	}

	@Override
	public Expression negate(){
		return argument;
	}
	
	@Override
	public Expression toCNF(){
		return argument.negate().toCNF();
	}

	@Override
	public Expression toDNF(){
		return argument.negate().toDNF();
	}
	
	@Override
	public String toString(){
		return "(" + NEGATION_PREDICATE + " " + argument.toString() + ")";
	}
	
	@Override
	public String getDescription(){
		return "negation";
	}
}
