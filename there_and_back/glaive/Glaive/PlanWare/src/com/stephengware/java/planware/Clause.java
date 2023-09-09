package com.stephengware.java.planware;

import java.util.LinkedList;

import com.stephengware.java.planware.logic.ClauseIterator;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.util.ImmutableArray;

public class Clause {

	public final Expression expression;
	public final ImmutableArray<Literal> literals;
	
	protected Clause(ClauseIterator literalIterator){
		this.expression = literalIterator.clause;
		LinkedList<Literal> literals = new LinkedList<>();
		while(literalIterator.hasNext())
			literals.add(literalIterator.next().literal);
		this.literals = new ImmutableArray<>(literals.toArray(new Literal[literals.size()]));
	}
	
	public boolean test(State state){
		for(int i=0; i<literals.length; i++)
			if(!state.testLiteral(literals.get(i)))
				return false;
		return true;
	}
	
	@Override
	public String toString(){
		return "[Clause: " + expression + "]";
	}
}
