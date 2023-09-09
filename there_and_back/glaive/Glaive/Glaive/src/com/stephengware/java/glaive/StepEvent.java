package com.stephengware.java.glaive;

import java.util.ArrayList;
import java.util.LinkedList;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.logic.Constant;

public class StepEvent extends Event {

	public final IntentionalStep source;
	private final ArrayList<Subplan> subplans = new ArrayList<>(3);
	private final LinkedList<Constant> orphans = new LinkedList<>();
	private final LinkedList<Constant> unexplained = new LinkedList<>();
	
	protected StepEvent(IntentionalStep step, int time, CausalState state){
		super(step, time, step.getPreconditionClauses(), step.getEffectLiterals(), state);
		this.source = step;
		for(int i=0; i<step.agents.length; i++){
			orphans.add(source.agents.get(i));
			unexplained.add(source.agents.get(i));
		}
	}
	
	final void registerSubplan(Subplan subplan){
		subplans.add(subplan);
	}
	
	public boolean isOrphan(){
		return orphans.size() != 0;
	}
	
	public boolean isOrphan(Constant agent){
		return orphans.contains(agent);
	}
	
	final void adopt(Constant agent){
		if(orphans.remove(agent) && !isOrphan()){
			for(int i=0; i<subplans.size(); i++){
				Subplan subplan = subplans.get(i);
				if(!subplan.hasOrphans())
					for(int j=0; j<subplan.steps.length; j++)
						subplan.steps.get(j).explain(subplan.goal.agent);
			}
		}
	}
	
	public boolean isExplained(){
		return unexplained.size() == 0;
	}
	
	public boolean isExplained(Constant agent){
		return !unexplained.contains(agent);
	}
		
	final void explain(Constant agent){
		unexplained.remove(agent);
	}
	
	public Iterable<Subplan> subplans(){
		return subplans;
	}
}
