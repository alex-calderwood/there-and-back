package com.stephengware.java.planware.ig;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.util.ImmutableSet;

public class StepNode extends com.stephengware.java.planware.pg.StepNode {

	public final IntentionGraph graph;
	public final IntentionalStep step;
	ImmutableSet<Motivation> motivations = null;
	private final boolean[] motivated;
	
	protected StepNode(IntentionGraph graph, IntentionalStep step){
		super(graph, step);
		this.graph = graph;
		this.step = step;
		this.motivated = new boolean[step.agents.length];
	}
	
	public ImmutableSet<Motivation> motivations(){
		return motivations;
	}
	
	public boolean isMotivated(){
		for(int i=0; i<motivated.length; i++)
			if(!motivated[i])
				return false;
		return true;
	}
	
	@Override
	public boolean isSatisfied(){
		return super.isSatisfied() && isMotivated();
	}
	
	@Override
	public void satisfy(){
		if(isMotivated())
			super.satisfy();
	}
	
	final boolean motivate(Constant agent){
		addToResetList();
		for(int i=0; i<step.agents.length; i++){
			if(step.agents.get(i).equals(agent)){
				if(motivated[i])
					return false;
				else{
					motivated[i] = true;
					if(isSatisfied())
						super.satisfy();
				}
			}
		}
		return false;
	}
	
	@Override
	public void reset(){
		super.reset();
		for(int i=0; i<motivated.length; i++)
			motivated[i] = false;
	}
}
