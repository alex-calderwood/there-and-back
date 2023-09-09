package com.stephengware.java.planware.logic;

public abstract class ExpressionObject extends EntityObject implements Expression {

	@Override
	public int compareTo(Entity other){
		if(other instanceof Negation)
			return 0 - other.compareTo(this);
		else
			return super.compareTo(other);
	}
}
