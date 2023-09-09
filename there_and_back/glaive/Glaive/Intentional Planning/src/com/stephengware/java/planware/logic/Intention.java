package com.stephengware.java.planware.logic;

import java.util.Collection;

import com.stephengware.java.planware.State;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.ModalExpression;
import com.stephengware.java.planware.logic.Term;

public class Intention extends ModalExpression implements Literal {

	public static final String INTENTION_MODALITY = "intends";
	
	public final Term agent;
	public final Expression goal;
	
	public Intention(Term agent, Expression goal){
		super(INTENTION_MODALITY, new Entity[]{agent, goal});
		this.agent = agent;
		this.goal = goal;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
		agent.collect(entityType, collection);
		goal.collect(entityType, collection);
	}

	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(substituted != this)
			return substituted;
		Term substitutedAgent = agent.substitute(substitution);
		Expression substitutedGoal = goal.substitute(substitution);
		if(substitutedAgent != agent || substitutedGoal != goal)
			return new Intention(substitutedAgent, substitutedGoal).substitute(substitution);
		else
			return this;
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
}
