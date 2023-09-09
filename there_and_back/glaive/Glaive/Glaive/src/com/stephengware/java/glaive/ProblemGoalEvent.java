package com.stephengware.java.glaive;

import com.stephengware.java.planware.Effect;
import com.stephengware.java.planware.Utilities;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.util.ImmutableArray;

public class ProblemGoalEvent extends Event {

	private static final ImmutableArray<Effect> NO_EFFECTS = new ImmutableArray<>(new Effect[0]);
	
	public final Expression source;
	
	protected ProblemGoalEvent(Expression goal, int time, CausalState state){
		super(goal, time, new ImmutableArray<>(Utilities.getPreconditionClauses("goal", goal)), NO_EFFECTS, state);
		this.source = goal;
	}
}
