package com.stephengware.java.planware.logic;

import java.util.Iterator;

import com.stephengware.java.planware.State;
import com.stephengware.java.planware.util.ArrayIterator;

public class NegatedLiteral extends Negation implements Literal {

	public final Literal argument;
	
	public NegatedLiteral(Literal argument){
		super(argument);
		this.argument = argument;
	}

	@Override
	public Iterator<? extends Literal> iterator(){
		return new ArrayIterator<Literal>(argument);
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
		else if(substitutedArgument == argument)
			return this;
		else if(substitutedArgument instanceof Literal)
			return new NegatedLiteral((Literal) substitutedArgument).substitute(substitution);
		else
			return new Negation(substitutedArgument).substitute(substitution);
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
	
	@Override
	public Literal negate(){
		return argument;
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
	public String getDescription(){
		return "negated literal";
	}
}
