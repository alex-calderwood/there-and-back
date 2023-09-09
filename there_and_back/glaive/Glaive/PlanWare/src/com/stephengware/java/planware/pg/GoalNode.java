package com.stephengware.java.planware.pg;

import com.stephengware.java.planware.logic.Expression;

public class GoalNode extends com.stephengware.java.planware.graph.GoalNode {

	protected final PlanGraph graph;
	private int level = -1;
	
	protected GoalNode(PlanGraph graph, Expression expression){
		super(graph, expression);
		this.graph = graph;
	}
	
	public int getLevel(){
		return level;
	}
	
	@Override
	public boolean activate(){
		if(super.activate()){
			level = graph.levels.countLevels() - 1;
			return true;
		}
		else
			return false;
	}
	

	@Override
	public void reset(){
		super.reset();
		level = -1;
	}
}
