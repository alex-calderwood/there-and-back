package com.stephengware.java.planware;

import java.util.LinkedList;

import com.stephengware.java.planware.logic.Conjunction;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;

public abstract class State implements Iterable<Literal>, Cloneable {
	
	@Override
	public int hashCode(){
		int hashCode = 1;
		for(Literal literal : this)
			hashCode = 31 * hashCode + literal.hashCode();
		return hashCode;
	}

	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof State){
			State otherState = (State) other;
			if(!testCompatibility(otherState) || !otherState.testCompatibility(this))
				return false;
			for(Literal literal : otherState)
				if(!isTrue(literal))
					return false;
			for(Literal literal : this)
				if(!otherState.isTrue(literal))
					return false;
			return true;
		}
		return false;
	}
	
	protected boolean testCompatibility(State other){
		return true;
	}
	
	public boolean isTrue(Expression expression){
		return expression.test(this);
	}
	
	public boolean isTrue(Literal literal){
		if(literal.isGround())
			return testLiteral(literal);
		else
			throw new NonDeterministicException(literal);
	}
	
	protected abstract boolean testLiteral(Literal literal);
	
	private boolean update = true;
	
	public final boolean impose(Expression expression){
		if(update){
			update = false;
			if(imposeExpression(expression)){
				update();
				update = true;
				return true;
			}
			else{
				update = true;
				return false;
			}
		}
		else
			return expression.impose(this);
	}
	
	protected boolean imposeExpression(Expression expression){
		return expression.impose(this);
	}
	
	public final boolean impose(Literal literal){
		if(!literal.isGround())
			throw new NonDeterministicException(literal);
		if(update){
			update = false;
			if(imposeLiteral(literal)){
				update();
				update = true;
				return true;
			}
			else{
				update = true;
				return false;
			}
		}
		else
			return imposeLiteral(literal);
	}
	
	protected abstract boolean imposeLiteral(Literal literal);
	
	protected void update(){}
	
	public boolean execute(Step step){
		if(isTrue(step.precondition))
			return impose(step.effect);
		else
			throw new IllegalArgumentException("The step \"" + step + "\" cannot be executed because its precondition is not satisfied.");
	}
	
	public Expression toExpression(){
		LinkedList<Literal> literals = new LinkedList<>();
		for(Literal literal : this)
			literals.add(literal);
		if(literals.size() == 0)
			return Expression.TRUE;
		else if(literals.size() == 1)
			return literals.get(0);
		else
			return new Conjunction(literals);
	}
	
	public abstract State clone();
	
	@Override
	public String toString(){
		return toExpression().toString();
	}
}
