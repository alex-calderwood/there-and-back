package com.stephengware.java.cpocl;

import java.util.ArrayList;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionFrame {

	private final CPOCLPlan parent;
	public final Constant agent;
	public final Expression goal;
	public final ImmutableSet<CPOCLStep> motivations;
	private final ArrayList<CPOCLStep> steps;
	
	@SuppressWarnings("unchecked")
	protected IntentionFrame(CPOCLPlan parent, IntentionFrame toClone){
		this.parent = parent;
		this.agent = toClone.agent;
		this.goal = toClone.goal;
		this.motivations = toClone.motivations;
		this.steps = (ArrayList<CPOCLStep>) toClone.steps.clone();
	}
	
	IntentionFrame(CPOCLPlan parent, Constant agent, Expression goal, CPOCLStep...motivations){
		this.parent = parent;
		this.agent = agent;
		this.goal = goal;
		for(int i=0; i<motivations.length; i++)
			if(motivations[i] == null)
				throw new FormatException("intention frame", "Motivating step " + (i + 1) + " cannot be null.");
		this.motivations = new ImmutableSet<>(motivations);
		if(this.motivations.length < 1)
			throw new FormatException("intention frame", "At least 1 motivating step is required.");
		this.steps = new ArrayList<>();
	}
	
	@Override
	public int hashCode(){
		int hc = 0;
		for(CPOCLStep step : motivations)
			hc += step.hashCode();
		for(CPOCLStep step : steps)
			hc += step.hashCode();
		return hc;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof IntentionFrame){
			IntentionFrame otherIF = (IntentionFrame) other;
			return motivations.equals(otherIF.motivations) && agent.equals(otherIF.agent) && goal.equals(otherIF.goal) && steps.equals(otherIF.steps);
		}
		return false;
	}
	
	public void addStep(int index){
		steps.add(parent.getStep(index));
		for(CPOCLStep motivation : motivations)
			parent.addOrdering(motivation.index, index);
	}
	
	public Iterable<CPOCLStep> steps(){
		return steps;
	}
	
	public IntentionFrame clone(CPOCLPlan parent){
		return new IntentionFrame(parent, this);
	}
}
