package com.stephengware.java.planware.ss;

import java.util.HashSet;
import java.util.Iterator;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.Negation;

class MonotonicallyIncreasingState extends State {

	final HashSet<Literal> literals = new HashSet<>();
	final HashSet<Step> steps = new HashSet<>();
	final HashSet<Axiom> axioms = new HashSet<>();
	
	@Override
	protected boolean testLiteral(Literal literal){
		if(literals.contains(literal))
			return true;
		else if(literal instanceof Negation){
			if(literals.contains(literal.negate()))
				return false;
			else{
				literal.impose(this);
				return true;
			}
		}
		else
			return false;
	}

	@Override
	protected boolean imposeLiteral(Literal literal){
		return literals.add(literal);
	}
	
	@Override
	public boolean execute(Step step){
		steps.add(step);
		return impose(step.effect);
	}
	
	public boolean apply(Axiom axiom){
		axioms.add(axiom);
		return impose(axiom.implies);
	}
	
	@Override
	public Iterator<Literal> iterator(){
		return literals.iterator();
	}

	@Override
	public State clone(){
		return null;
	}
}
