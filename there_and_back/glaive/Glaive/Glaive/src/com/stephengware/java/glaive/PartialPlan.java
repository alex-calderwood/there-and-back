package com.stephengware.java.glaive;

import java.util.Iterator;

import com.stephengware.java.planware.IntentionalStep;

public class PartialPlan {

	public static final PartialPlan EMPTY = new PartialPlan();
	
	public final int length;
	public final IntentionalStep step;
	public final PartialPlan rest;
	
	private PartialPlan(){
		this.length = 0;
		this.step = null;
		this.rest = null;
	}
	
	private PartialPlan(Iterator<? extends IntentionalStep> steps){
		this.step = steps.next();
		if(steps.hasNext())
			this.rest = new PartialPlan(steps);
		else
			this.rest = EMPTY;
		this.length = rest.length + 1;			
	}
	
	public static PartialPlan newInstance(Iterable<? extends IntentionalStep> steps){
		if(steps == null)
			return EMPTY;
		Iterator<? extends IntentionalStep> iterator = steps.iterator();
		if(!iterator.hasNext())
			return EMPTY;
		return new PartialPlan(iterator);
	}
	
	public boolean contains(IntentionalStep step){
		PartialPlan plan = this;
		while(plan != EMPTY){
			if(plan.step.equals(step))
				return true;
			plan = plan.rest;
		}
		return false;
	}
	
	@Override
	public String toString(){
		return "[Partial Plan: " + length + " steps]";
	}
}
