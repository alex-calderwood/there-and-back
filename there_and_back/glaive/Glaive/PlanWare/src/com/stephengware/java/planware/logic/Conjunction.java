package com.stephengware.java.planware.logic;

import java.util.LinkedList;
import java.util.List;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.State;

public class Conjunction extends NAryBooleanExpression {
		
	protected static final String CONJUNCTION_PREDICATE = "and";

	public Conjunction(Expression...arguments){
		super(CONJUNCTION_PREDICATE, flatten(arguments));
		if(arguments.length < 2)
			throw new FormatException(getDescription(), "2 or more arguments required.");
	}
	
	private static final Expression[] flatten(Expression[] arguments){
		LinkedList<Expression> flat = new LinkedList<>();
		for(Expression argument : arguments){
			if(argument == Expression.TRUE)
				continue;
			else if(argument instanceof Conjunction){
				for(Expression innerArgument : ((Conjunction) argument).arguments)
					flat.add(innerArgument);
			}
			else
				flat.add(argument);
		}
		return flat.toArray(new Expression[flat.size()]);
	}
	
	public Conjunction(List<? extends Expression> arguments){
		this(arguments.toArray(new Expression[arguments.size()]));
	}
	
	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(this != substituted)
			return substituted;
		LinkedList<Expression> substitutedArguments = new LinkedList<>();
		boolean different = false;
		for(Expression argument : arguments){
			Expression transformedArgument = argument.substitute(substitution);
			if(transformedArgument == Expression.FALSE)
				return Expression.FALSE.substitute(substitution);
			else if(transformedArgument == Expression.TRUE){
				different = true;
				continue;
			}
			if(argument != transformedArgument)
				different = true;
			substitutedArguments.add(transformedArgument);
		}
		if(!different)
			return this;
		else if(substitutedArguments.size() == 0)
			return Expression.TRUE.substitute(substitution);
		else if(substitutedArguments.size() == 1)
			return substitutedArguments.get(0);
		else
			return new Conjunction(substitutedArguments).substitute(substitution);
	}
	
	@Override
	public boolean test(State state){
		for(int i=0; i<arguments.length; i++)
			if(!arguments.get(i).test(state))
				return false;
		return true;
	}
	
	@Override
	public boolean isImposable(){
		for(int i=0; i<arguments.length; i++)
			if(!arguments.get(i).isImposable())
				return false;
		return true;
	}
	
	@Override
	public boolean impose(State state){
		boolean result = false;
		for(int i=0; i<arguments.length; i++)
			result = arguments.get(i).impose(state) || result;
		return result;
	}

	@Override
	public Disjunction negate(){
		return new Disjunction(negateArguments());
	}

	@Override
	public Expression toCNF(){
		return NormalFormUtilities.toCNF(this);
	}

	@Override
	public Expression toDNF(){
		return NormalFormUtilities.toDNF(this);
	}
	
	@Override
	public String getDescription(){
		return "conjunction";
	}
}
