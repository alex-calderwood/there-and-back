package com.stephengware.java.planware.ig;

import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Intention;
import com.stephengware.java.planware.pg.LiteralNode;

public class IntentionNode extends LiteralNode {

	public final Constant agent;
	public final GoalNode goal;
	
	protected IntentionNode(IntentionGraph graph, Intention intention){
		super(graph, intention);
		this.agent = (Constant) intention.agent;
		this.goal = graph.makeGoalNode(intention.goal);
	}
	
	@Override
	public boolean activate(){
		if(super.activate()){
			goal.motivate(agent);
			return true;
		}
		return false;
	}
}
