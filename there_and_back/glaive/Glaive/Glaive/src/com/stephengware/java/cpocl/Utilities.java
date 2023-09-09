package com.stephengware.java.cpocl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.stephengware.java.glaive.Event;
import com.stephengware.java.glaive.GlaivePlan;
import com.stephengware.java.glaive.ProblemGoalEvent;
import com.stephengware.java.glaive.StepEvent;
import com.stephengware.java.glaive.Subplan;
import com.stephengware.java.planware.Effect;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Literal;

public class Utilities {
	
	public static final List<StepEvent> getSteps(GlaivePlan plan){
		HashSet<StepEvent> steps = new HashSet<>();
		HashSet<Subplan> subplans = new HashSet<>();
		collectStepsAndSubplans(plan, steps, subplans);
		List<StepEvent> list = toList(steps);
		Collections.sort(list, SORT_BY_TIME);
		return list;
	}
	
	private static final Comparator<StepEvent> SORT_BY_TIME = new Comparator<StepEvent>(){

		@Override
		public int compare(StepEvent se1, StepEvent se2){
			return se1.time - se2.time;
		}
	};
	
	public static final List<Subplan> getSubplans(GlaivePlan plan){
		HashSet<StepEvent> steps = new HashSet<>();
		HashSet<Subplan> subplans = new HashSet<>();
		collectStepsAndSubplans(plan, steps, subplans);
		return toList(subplans);
	}
	
	@SuppressWarnings("unchecked")
	private static final void collectStepsAndSubplans(GlaivePlan plan, HashSet<StepEvent> steps, HashSet<Subplan> subplans){
		for(int i=1; i<=plan.countSteps(); i++)
			collectStep(plan.getStep(i), steps);
		int stepCount = 0;
		while(steps.size() > stepCount){
			stepCount = steps.size();
			Set<StepEvent> clone = (Set<StepEvent>) steps.clone();
			for(StepEvent step : clone)
				collectSubplansFor(plan, step, steps, subplans);
		}
	}
	
	private static final void collectStep(Event event, Set<StepEvent> steps){
		if(steps.contains(event))
			return;
		if(event instanceof StepEvent)
			steps.add((StepEvent) event);
		for(com.stephengware.java.glaive.CausalLink link : event.inLinks)
			collectStep(link.tail, steps);
	}
	
	private static final void collectSubplansFor(GlaivePlan plan, StepEvent step, Set<StepEvent> steps, Set<Subplan> subplans){
		for(Constant agent : step.source.agents)
			collectSubplanFor(plan, step, agent, steps, subplans);
	}
	
	private static final void collectSubplanFor(GlaivePlan plan, StepEvent step, Constant agent, Set<StepEvent> steps, Set<Subplan> subplans){
		Subplan bestSubplan = null;
		int fewestNewSteps = Integer.MAX_VALUE;
		for(Subplan subplan : step.subplans()){
			if(subplan.goal.agent.equals(agent)){
				int newSteps = countNewSteps(plan, subplan, steps, subplans);
				if(newSteps <= fewestNewSteps){
					if(newSteps < fewestNewSteps || (newSteps == fewestNewSteps && subplan.steps.length < bestSubplan.steps.length)){
						bestSubplan = subplan;
						fewestNewSteps = newSteps;
					}
				}
			}
		}
		if(bestSubplan != null)
			collectSubplan(bestSubplan, steps, subplans);
	}
	
	private static final int countNewSteps(GlaivePlan plan, Subplan subplan, Set<StepEvent> steps, Set<Subplan> subplans){
		int count = 0;
		for(StepEvent step : subplan.steps)
			if(!steps.contains(step))
				count++;
		return count;
	}

	private static final void collectSubplan(Subplan subplan, Set<StepEvent> steps, Set<Subplan> subplans){
		if(subplans.add(subplan)){
			collectStep(subplan.goal.motivation, steps);
			for(StepEvent step : subplan.steps)
				collectStep(step, steps);
		}
	}
	
	private static final <T> List<T> toList(Set<T> set){
		ArrayList<T> list = new ArrayList<>(set.size());
		for(T element : set)
			list.add(element);
		return list;
	}
	
	public static CPOCLPlan toCPOCL(GlaivePlan plan){
		CPOCLPlan cpocl = new CPOCLPlan(plan.name, plan.problem);
		// Collect steps and subplans.
		HashSet<StepEvent> events = new HashSet<>();
		HashSet<Subplan> subplans = new HashSet<>();
		collectStepsAndSubplans(plan, events, subplans);
		// Add steps.
		HashMap<StepEvent, Integer> indices = new HashMap<>();
		for(StepEvent event : events){
			CPOCLStep step = cpocl.addStep(event.source, isExecuted(event, plan));
			indices.put(event, step.index);
		}
		// Add causal links.
		for(StepEvent event : events)
			addCausalLinks(event, indices, cpocl);
		ProblemGoalEvent goalEvent = plan.getProblemGoal();
		for(com.stephengware.java.glaive.CausalLink link : goalEvent.inLinks)
			addCausalLinks(link.tail, link.label, cpocl.getEndStep().index, indices, cpocl);
		// Add additional orderings to prevent threatened causal links.
		StepEvent[] glaive = getGlaiveSteps(events);
		for(CausalLink link : cpocl.causalLinks()){
			for(CPOCLStep step : cpocl.steps()){
				if(threatens(step, link, cpocl)){
					int s = link.tail.index;
					int t = step.index;
					int u = link.head.index;
					if(getGlaiveIndex(step, cpocl, glaive, indices) < getGlaiveIndex(link.tail, cpocl, glaive, indices))
						cpocl.addOrdering(t, s);
					else
						cpocl.addOrdering(u, t);
				}
			}
		}
		// Add intention frames.
		for(Subplan subplan : subplans){
			IntentionFrame frame = cpocl.addIntentionFrame(subplan.goal.agent, subplan.goal.goal, getMotivatingSteps(subplan, indices));
			for(StepEvent event : subplan.steps)
				frame.addStep(indices.get(event));
		}
		return new CPOCLPlan(cpocl);
	}
	
	public static final boolean isExecuted(StepEvent step, GlaivePlan plan){
		for(int i=1; i<=plan.countSteps(); i++)
			if(plan.getStep(i) == step)
				return true;
		return false;
	}
	
	private static final void addCausalLinks(Event event, HashMap<StepEvent, Integer> indices, CPOCLPlan plan){
		for(com.stephengware.java.glaive.CausalLink link : event.inLinks)
			addCausalLinks(link.tail, link.label, indices.get(event), indices, plan);
	}
	
	private static final void addCausalLinks(Event tail, Literal label, int head, HashMap<StepEvent, Integer> indices, CPOCLPlan plan){
		if(tail instanceof StepEvent)
			plan.addCausalLink(indices.get(tail), label, head);
		else if(tail.time == 0)
			plan.addCausalLink(0, label, head);
		else
			for(com.stephengware.java.glaive.CausalLink link : tail.inLinks)
				addCausalLinks(link.tail, label, head, indices, plan);
	}
	
	private static final StepEvent[] getGlaiveSteps(HashSet<StepEvent> events){
		StepEvent[] array = events.toArray(new StepEvent[events.size()]);
		Arrays.sort(array, new Comparator<StepEvent>(){
			@Override
			public int compare(StepEvent e1, StepEvent e2){
				return e1.time - e2.time;
			}
		});
		return array;
	}
	
	private static final boolean threatens(CPOCLStep step, CausalLink link, CPOCLPlan cpocl){
		for(Effect effect : step.getEffectLiterals())
			if(effect.literal.negate().equals(link.label) &&
					cpocl.canAddOrdering(link.tail.index, step.index) &&
					cpocl.canAddOrdering(step.index, link.head.index) &&
					step.executed &&
					link.head.executed)
				return true;
		return false;
	}
	
	private static final int getGlaiveIndex(CPOCLStep step, CPOCLPlan cpocl, StepEvent[] glaive, HashMap<StepEvent, Integer> indices){
		if(cpocl.getStartStep() == step)
			return 0;
		else if(cpocl.getEndStep() == step)
			return glaive.length + 1;
		for(int i=0; i<glaive.length; i++)
			if(indices.get(glaive[i]) == step.index)
				return i + 1;
		throw new IllegalArgumentException("The step \"" + step + "\" does not appear in the plan, so its index cannot be found.");
	}
	
	private static final int[] getMotivatingSteps(Subplan subplan, HashMap<StepEvent, Integer> indices){
		HashSet<Integer> motivations = new HashSet<>();
		collectMotivatingSteps(subplan.goal.motivation, motivations, indices);
		Integer[] m = motivations.toArray(new Integer[motivations.size()]);
		int[] result = new int[m.length];
		for(int i=0; i<m.length; i++)
			result[i] = m[i];
		return result;
	}
	
	private static final void collectMotivatingSteps(Event event, Set<Integer> motivations, HashMap<StepEvent, Integer> indices){
		if(event.time == 0)
			motivations.add(0);
		if(event instanceof StepEvent)
			motivations.add(indices.get(event));
		else
			for(com.stephengware.java.glaive.CausalLink link : event.inLinks)
				collectMotivatingSteps(link.tail, motivations, indices);
	}
}
