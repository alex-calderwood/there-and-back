package com.stephengware.java.planware;

import java.util.HashSet;
import java.util.Iterator;

import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.Negation;

public class HashState extends AxiomTreeState {

	private final HashSet<Literal> positiveLiterals;
	
	@SuppressWarnings("unchecked")
	protected HashState(HashState state){
		super(state.axiomTree);
		this.positiveLiterals = (HashSet<Literal>) state.positiveLiterals.clone();
	}
	
	public HashState(AxiomTree axiomTree){
		super(axiomTree);
		this.positiveLiterals = new HashSet<>();
	}

	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof State){
			State otherState = (State) other;
			if(!testCompatibility(otherState) || !otherState.testCompatibility(this))
				return false;
			int literalCount = 0;
			for(Literal literal : otherState){
				if(isTrue(literal))
					literalCount++;
				else
					return false;
			}
			return literalCount == positiveLiterals.size();
		}
		return false;
	}
	
	@Override
	protected boolean testLiteral(Literal literal){
		if(literal instanceof Negation)
			return !positiveLiterals.contains(literal.negate());
		else
			return positiveLiterals.contains(literal);
	}

	@Override
	protected boolean imposeLiteral(Literal literal){
		if(!literal.isGround())
			throw new NonDeterministicException(literal);
		if(literal instanceof Negation)
			return positiveLiterals.remove(literal.negate());
		else
			return positiveLiterals.add(literal);
	}
	
	@Override
	public Iterator<Literal> iterator(){
		return positiveLiterals.iterator();
	}

	@Override
	public HashState clone(){
		return new HashState(this);
	}
}
