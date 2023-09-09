package com.stephengware.java.planware.ig;

import java.util.HashMap;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Expression;

public class GoalNode extends com.stephengware.java.planware.pg.GoalNode {
		
	public final IntentionGraph graph;
	final HashMap<Constant, GoalTree> intentionalAncestors  = new HashMap<>();
	
	protected GoalNode(IntentionGraph graph, Expression expression){
		super(graph, expression);
		this.graph = graph;
	}
	
	final void findIntentionalAncestors(Constant agent){
		intentionalAncestors.put(agent, GoalTree.makeGoalTree(agent, this));
	}
	
	public void motivate(Constant agent){
		intentionalAncestors.get(agent).motivate();
	}
}
