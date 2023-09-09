package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.Iterator;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.util.ImmutableArray;

public abstract class NAryBooleanExpression extends BooleanExpression {

	public final ImmutableArray<Expression> arguments;
	private final int hashCode;
	
	protected NAryBooleanExpression(String operator, Expression[] arguments){
		super(operator);
		if(arguments == null)
			throw new FormatException(getDescription(), "Arguments cannot be null.");
		for(int i=0; i<arguments.length; i++){
			if(arguments[i] == null)
				throw new FormatException(getDescription(), "Argument " + (i + 1) + " cannot be null.");
		}
		this.arguments = new ImmutableArray<Expression>(arguments);
		int hc = operator.hashCode();
		for(Expression argument : arguments)
			hc = 31 * hc + argument.hashCode();
		this.hashCode = hc;
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof NAryBooleanExpression){
			NAryBooleanExpression otherBooleanExpression = (NAryBooleanExpression) other;
			if(!testCompatibility(otherBooleanExpression) || !otherBooleanExpression.testCompatibility(this))
				return false;
			if(operator != otherBooleanExpression.operator || arguments.length != otherBooleanExpression.arguments.length)
				return false;
			for(int i=0; i<arguments.length; i++)
				if(!arguments.get(i).equals(otherBooleanExpression.arguments.get(i)))
					return false;
			return true;
		}
		return false;
	}
	
	protected boolean testCompatibility(NAryBooleanExpression other){
		return true;
	}
	
	@Override
	public Iterator<? extends Expression> iterator(){
		return arguments.iterator();
	}
	
	@Override
	public boolean isGround(){
		for(int i=0; i<arguments.length; i++)
			if(!arguments.get(i).isGround())
				return false;
		return true;
	}
	
	@Override
	public boolean occurs(Entity entity){
		if(equals(entity))
			return true;
		for(int i=0; i<arguments.length; i++)
			if(arguments.get(i).occurs(entity))
				return true;
		return false;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
		for(Expression argument : arguments)
			argument.collect(entityType, collection);
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof NAryBooleanExpression){
			NAryBooleanExpression otherBooleanExpression = (NAryBooleanExpression) other;
			if(operator != otherBooleanExpression.operator || arguments.length != otherBooleanExpression.arguments.length)
				return false;
			for(int i=0; i<arguments.length; i++)
				if(!arguments.get(i).subsumes(otherBooleanExpression.arguments.get(i), taxonomy))
					return false;
			return true;
		}
		return false;
	}

	@Override
	public boolean isTestable(){
		for(int i=0; i<arguments.length; i++)
			if(!arguments.get(i).isTestable())
				return false;
		return true;
	}
	
	@Override
	public abstract Expression negate();
	
	protected Expression[] negateArguments(){
		Expression[] negatedArguments = new Expression[arguments.length];
		for(int i=0; i<arguments.length; i++)
			negatedArguments[i] = arguments.get(i).negate();
		return negatedArguments;
	}
	
	@Override
	public String toString(){
		String str = "(" + operator;
		for(Expression argument : arguments)
			str += " " + argument;
		return str + ")";
	}
}
