package com.stephengware.java.planware.logic;

import java.util.Iterator;

import com.stephengware.java.planware.util.ArrayIterator;

public class TermEquality extends Equality {

	public final Term left;
	public final Term right;
	
	public TermEquality(Term left, Term right){
		super(left, right);
		this.left = left;
		this.right = right;
	}
	
	@Override
	public Iterator<? extends Term> iterator(){
		return new ArrayIterator<Term>(new Term[]{left, right});
	}

	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(substituted != this)
			return substituted;
		Term substitutedLeft = left.substitute(substitution);
		Term substitutedRight = right.substitute(substitution);
		if(substitutedLeft.isGround() && substitutedRight.isGround()){
			if(substitutedLeft.equals(substitutedRight))
				return Expression.TRUE.substitute(substitution);
			else
				return Expression.FALSE.substitute(substitution);
		}
		if(substitutedLeft == left && substitutedRight == right)
			return this;
		else
			return new TermEquality(substitutedLeft, substitutedRight).substitute(substitution);
	}
}
