package com.stephengware.java.planware.ff;

import java.util.Iterator;
import java.util.NoSuchElementException;

import com.stephengware.java.planware.ListPlan;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.ss.StateSpaceSearchNode;
import com.stephengware.java.planware.util.CountableIterable;

public class FastForwardSearchNode extends StateSpaceSearchNode {

	public final ListPlan plan;
	public final State state;
	CountableIterable<? extends Step> relaxedPlan = null;
	Iterator<? extends Step> nextSteps = null;
	
	public FastForwardSearchNode(ListPlan plan, State state){
		this.plan = plan;
		this.state = state;
	}
	
	@Override
	public ListPlan getPlan(){
		return plan;
	}
	
	@Override
	public State getState(){
		return state;
	}
	
	public CountableIterable<? extends Step> getRelaxedPlan(){
		if(relaxedPlan == null)
			throw new IllegalStateException("This node has not yet been evaluated by the Fast Forward heuristic, so it cannot offer its relaxed plan.");
		else
			return relaxedPlan;
	}
	
	public boolean hasNextSuccessor(){
		if(nextSteps == null)
			throw new IllegalStateException("This node has not yet been evaluated by the Fast Forward heuristic, so it cannot offer its next steps.");
		else
			return nextSteps.hasNext();
	}
	
	public Step getNextSuccessor(){
		if(!hasNextSuccessor())
			throw new NoSuchElementException("This node has no more successors.");
		else
			return nextSteps.next();
	}
}
