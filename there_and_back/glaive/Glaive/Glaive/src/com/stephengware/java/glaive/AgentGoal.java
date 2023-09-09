package com.stephengware.java.glaive;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.NoSuchElementException;

import com.stephengware.java.planware.Clause;
import com.stephengware.java.planware.Utilities;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.util.ImmutableArray;

public class AgentGoal {

	public final Event motivation;
	public final Constant agent;
	public final Expression goal;
	private final ImmutableArray<Clause> preconditionClauses;
	public final AgentGoalEvent satisfaction;
	final LinkedList<Subplan> subplans;
	private final int hashCode;
	
	private AgentGoal(AgentGoal unsatisfied, AgentGoalEvent satisfaction){
		this.motivation = unsatisfied.motivation;
		this.agent = unsatisfied.agent;
		this.goal = unsatisfied.goal;
		this.preconditionClauses = unsatisfied.preconditionClauses;
		this.satisfaction = satisfaction;
		this.subplans = unsatisfied.subplans;
		this.hashCode = unsatisfied.hashCode;
	}
	
	protected AgentGoal(Event motivation, Constant agent, Expression goal){
		this.motivation = motivation;
		this.agent = agent;
		this.goal = goal;
		this.preconditionClauses = new ImmutableArray<>(Utilities.getPreconditionClauses("goal", goal));
		this.satisfaction = null;
		this.subplans = new LinkedList<>();
		this.hashCode = motivation.hashCode() * agent.hashCode() * goal.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof AgentGoal){
			AgentGoal otherGoal = (AgentGoal) other;
			return motivation.source.equals(otherGoal.motivation.source) &&
					agent.equals(otherGoal.agent) &&
					goal.equals(otherGoal.goal);
		}
		return false;
	}
	
	public ImmutableArray<Clause> getPreconditionClauses(){
		return preconditionClauses;
	}
	
	public boolean isSatisfied(){
		return satisfaction != null;
	}
	
	final AgentGoal satisfy(AgentGoalEvent event){
		return new AgentGoal(this, event);
	}
	
	public int countSubplans(){
		int count = 0;
		for(Subplan subplan : subplans)
			if(!subplan.hasOrphans())
				count++;
		return count;
	}
	
	private final class SubplanIterator implements Iterator<Subplan> {

		private final Iterator<Subplan> subplans = AgentGoal.this.subplans.iterator();
		private Subplan next = null;
		
		public SubplanIterator(){
			advance();
		}
		
		private final void advance(){
			while(subplans.hasNext()){
				next = subplans.next();
				if(!next.hasOrphans())
					return;
			}
			next = null;
		}
		
		@Override
		public boolean hasNext(){
			return next != null;
		}

		@Override
		public Subplan next(){
			if(!hasNext())
				throw new NoSuchElementException("There are no more subplans for this goal.");
			Subplan subplan = next;
			advance();
			return subplan;
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}
	
	private final Iterable<Subplan> subplanIterable = new Iterable<Subplan>(){

		@Override
		public Iterator<Subplan> iterator(){
			return new SubplanIterator();
		}
	};
	
	public final Iterable<Subplan> subplans(){
		return subplanIterable;
	}
	
	final void addSubplan(Subplan subplan){
		if(!subplans.contains(subplan))
			subplans.add(subplan);
	}
	
	@Override
	public String toString(){
		return "[Goal for " + agent + " to achieve " + goal + "]";
	}
}
