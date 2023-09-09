package com.stephengware.java.planware.logic;

import com.stephengware.java.planware.State;

public class ExpressionVariable extends Variable implements Literal {
	
	private final boolean isImposable;
	
	public ExpressionVariable(String name, boolean isImposable){
		super(name);
		this.isImposable = isImposable;
	}
	
	public ExpressionVariable(String name){
		this(name, false);
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof ExpressionVariable){
			ExpressionVariable otherEV = (ExpressionVariable) other;
			if(!testCompatibility(otherEV) || !otherEV.testCompatibility(this))
				return false;
			return name != otherEV.name;
		}
		return false;
	}
	
	protected boolean testCompatibility(ExpressionVariable other){
		return true;
	}
	
	@Override
	public boolean occurs(Entity entity){
		return equals(entity);
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
		throw new UnsupportedOperationException("A " + getDescription() + " cannot be tested because it is not ground.");
	}

	@Override
	public boolean isImposable(){
		return isImposable;
	}
	
	@Override
	public boolean impose(State state){
		throw new UnsupportedOperationException("A " + getDescription() + " cannot be imposed because it is not ground.");
	}

	@Override
	public Literal negate(){
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
	public Variable newInstance(){
		return new ExpressionVariable(getUniqueName());
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof Expression){
			Expression otherExpression = (Expression) other;
			if(!otherExpression.isTestable())
				return false;
			if(isImposable)
				return otherExpression.isImposable();
			else
				return true;
		}
		else
			return false;
	}
}
