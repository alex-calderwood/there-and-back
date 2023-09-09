package com.stephengware.java.planware.pg;

import com.stephengware.java.planware.Step;

public class StepNode extends com.stephengware.java.planware.graph.StepNode {

	protected final PlanGraph graph;
	private int level = -1;
	
	protected StepNode(PlanGraph graph, Step step){
		super(graph, step);
		this.graph = graph;
	}
	
	@Override
	public boolean activate(){
		if(super.activate()){
			level = graph.levels.countLevels() - 1;
			graph.levels.addStep(this);
			return true;
		}
		return false;
	}
	
	@Override
	public void satisfy(){
		super.satisfy();
		graph.nextSteps.add(this);
	}
	
	@Override
	public void reset(){
		super.reset();
		level = -1;
	}
	
	public int getLevel(){
		return level;
	}
}
