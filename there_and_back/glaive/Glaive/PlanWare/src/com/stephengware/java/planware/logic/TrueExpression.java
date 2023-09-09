package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.Iterator;

import com.stephengware.java.planware.State;

public final class TrueExpression extends ExpressionObject implements Literal {
	
	TrueExpression(){}
	
	@Override
	public int hashCode(){
		return 1;
	}
	
	@Override
	public boolean equals(Object other){
		return this == other;
	}

	@Override
	public Iterator<? extends Entity> iterator(){
		return NO_ENTITIES;
	}

	@Override
	public boolean isGround(){
		return true;
	}
	
	@Override
	public boolean occurs(Entity entity){
		return equals(entity);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType == FalseExpression.class)
			collection.add((E) this);
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		return equals(other);
	}
	
	@Override
	public Expression substitute(Substitution substitution){
		return substitution.substitute(this, Expression.class);
	}
	
	@Override
	public boolean isTestable(){
		return true;
	}
	
	@Override
	public boolean test(State state){
		return true;
	}
	
	@Override
	public boolean isImposable(){
		return true;
	}
	
	@Override
	public boolean impose(State state){
		return false;
	}

	@Override
	public Literal negate() {
		return FALSE;
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
		return "true";
	}
	
	@Override
	public String getDescription(){
		return "true expression";
	}
}
