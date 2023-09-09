package com.stephengware.java.planware.logic;

import java.util.Collection;

import com.stephengware.java.planware.State;

public class Delegation extends ModalExpression implements Literal {

	public static final String DELEGATION_MODALITY = "delegated";
	
	public final Term master;
	public final Expression goal;
	public final Term slave;
	
	public Delegation(Term master, Expression goal, Term slave){
		super(DELEGATION_MODALITY, new Entity[]{master, goal, slave});
		this.master = master;
		this.goal = goal;
		this.slave = slave;
	}

	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
		master.collect(entityType, collection);
		goal.collect(entityType, collection);
		slave.collect(entityType, collection);
	}
	
	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(substituted != this)
			return substituted;
		Term substitutedMaster = master.substitute(substitution);
		Expression substitutedGoal = goal.substitute(substitution);
		Term substitutedSlave = slave.substitute(substitution);
		if(substitutedMaster != master || substitutedGoal != goal || substitutedSlave != slave)
			return new Delegation(substitutedMaster, substitutedGoal, substitutedSlave).substitute(substitution);
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
