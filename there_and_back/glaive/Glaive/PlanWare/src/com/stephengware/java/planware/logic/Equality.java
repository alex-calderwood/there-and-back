package com.stephengware.java.planware.logic;

import java.util.Collection;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.State;

public abstract class Equality extends ExpressionObject implements Literal {
		
	protected static final String EQUALITY_PREDICATE = "=";

	public final Entity left;
	public final Entity right;
	private final int hashCode;
	
	public Equality(Entity left, Entity right){
		if(left == null)
			throw new FormatException(getDescription(), "Left side cannot be null.");
		this.left = left;
		if(right == null)
			throw new FormatException(getDescription(), "Right side cannot be null.");
		this.right = right;
		this.hashCode = EQUALITY_PREDICATE.hashCode() + left.hashCode() + right.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Equality){
			Equality otherEquality = (Equality) other;
			if(!testCompatibility(otherEquality) || !otherEquality.testCompatibility(this))
				return false;
			return (left.equals(otherEquality.left) && right.equals(otherEquality.right)) || (left.equals(otherEquality.right) && right.equals(otherEquality.left));
		}
		return false;
	}
	
	protected boolean testCompatibility(Equality other){
		return true;
	}
	
	@Override
	public boolean isGround(){
		return left.isGround() && right.isGround();
	}

	@Override
	public boolean occurs(Entity entity){
		return equals(entity) || left.occurs(entity) || right.occurs(entity);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
		left.collect(entityType, collection);
		right.collect(entityType, collection);
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof Equality){
			Equality otherEquality = (Equality) other;
			return (left.subsumes(otherEquality.left, taxonomy) && right.subsumes(otherEquality.right, taxonomy)) || (left.subsumes(otherEquality.right, taxonomy) && right.subsumes(otherEquality.left, taxonomy));
		}
		return false;
	}

	@Override
	public boolean isTestable(){
		return true;
	}
	
	@Override
	public boolean test(State state){
		if(isGround())
			return left.equals(right);
		else
			throw new UnsupportedOperationException(toString() + " cannot be tested because it is not ground.");
	}

	@Override
	public boolean isImposable(){
		return false;
	}
	
	@Override
	public boolean impose(State state){
		throw new UnsupportedOperationException("An " + getDescription() + " is not imposable.");
	}

	@Override
	public NegatedLiteral negate(){
		return new NegatedLiteral(this);
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
		return "(" + EQUALITY_PREDICATE + " " + left + " " + right + ")";
	}
	
	@Override
	public String getDescription(){
		return "equality";
	}
}
