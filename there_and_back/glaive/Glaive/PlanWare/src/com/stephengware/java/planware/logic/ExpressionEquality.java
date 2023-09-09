package com.stephengware.java.planware.logic;

import java.util.Iterator;

import com.stephengware.java.planware.util.ArrayIterator;

public class ExpressionEquality extends Equality {

	public final Expression left;
	public final Expression right;
	
	public ExpressionEquality(Expression left, Expression right){
		super(left, right);
		this.left = left;
		this.right = right;
	}
	
	@Override
	public Iterator<? extends Expression> iterator(){
		return new ArrayIterator<Expression>(new Expression[]{left, right});
	}

	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(this != substituted)
			return substituted;
		Expression substitutedLeft = left.substitute(substitution);
		Expression substitutedRight = right.substitute(substitution);
		if(substitutedLeft.isGround() && substitutedRight.isGround()){
			if(substitutedLeft.equals(substitutedRight))
				return Expression.TRUE.substitute(substitution);
			else
				return Expression.FALSE.substitute(substitution);
		}
		if(substitutedLeft == left && substitutedRight == right)
			return this;
		else
			return new ExpressionEquality(substitutedLeft, substitutedRight).substitute(substitution);
	}
}
