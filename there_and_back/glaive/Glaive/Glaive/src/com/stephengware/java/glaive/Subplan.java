package com.stephengware.java.glaive;

import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;

import com.stephengware.java.planware.CausalPath;
import com.stephengware.java.planware.util.ImmutableSet;

public class Subplan {

	public final AgentGoal goal;
	public final ImmutableSet<StepEvent> steps;
	
	protected Subplan(AgentGoal goal){
		if(goal.satisfaction == null)
			throw new IllegalArgumentException("The goal \"" + goal.goal + "\" is not satisfied.");
		this.goal = goal;
		this.steps = getMembers(goal);
		for(int i=0; i<steps.length; i++){
			steps.get(i).registerSubplan(this);
			steps.get(i).adopt(goal.agent);
		}
		if(!goal.subplans.contains(this))
			goal.subplans.add(this);
	}
	
	private static final Comparator<Event> SORT_EVENTS_BY_TIME = new Comparator<Event>(){

		@Override
		public int compare(Event event1, Event event2){
			return event1.time - event2.time;
		}
	};
	
	private static final ImmutableSet<StepEvent> getMembers(AgentGoal goal){
		TreeSet<StepEvent> steps = new TreeSet<>(SORT_EVENTS_BY_TIME);
		collectMembers(goal, goal.satisfaction, CausalPath.EMPTY, steps);
		return new ImmutableSet<StepEvent>(steps, StepEvent.class);
	}
	
	private static final void collectMembers(AgentGoal goal, Event event, CausalPath path, Set<StepEvent> steps){
		if(event.time <= goal.motivation.time)
			return;
		if(event instanceof StepEvent){
			StepEvent stepEvent = (StepEvent) event;
			if(stepEvent.source.agents.contains(goal.agent))
				steps.add(stepEvent);
			else
				return;
		}
		for(int i=0; i<event.inLinks.length; i++){
			CausalLink link = event.inLinks.get(i);
			if(path.contains(link.label))
				continue;
			collectMembers(goal, link.tail, path.add(link.label), steps);
		}
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Subplan){
			Subplan otherSubplan = (Subplan) other;
			if(!goal.equals(otherSubplan.goal) || steps.length != otherSubplan.steps.length)
				return false;
			for(int i=0; i<steps.length; i++)
				if(!steps.get(i).source.equals(otherSubplan.steps.get(i).source))
					return false;
			return true;
		}
		return false;
	}
	
	public boolean hasOrphans(){
		for(int i=0; i<steps.length; i++)
			if(steps.get(i).isOrphan())
				return true;
		return false;
	}
	
	@Override
	public String toString(){
		return "[Subplan for " + goal.agent + " to achieve " + goal.goal + ": " + steps.length + " steps]";
	}
}
