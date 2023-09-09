package com.stephengware.java.glaive;

import com.stephengware.java.planware.Effect;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.util.ImmutableArray;

public class AgentGoalEvent extends Event {

	private static final ImmutableArray<Effect> NO_EFFECTS = new ImmutableArray<>(new Effect[0]);
	
	public final Expression source;
	
	protected AgentGoalEvent(AgentGoal goal, int time, CausalState state){
		super(goal.goal, time, goal.getPreconditionClauses(), NO_EFFECTS, state);
		this.source = goal.goal;
	}
}
