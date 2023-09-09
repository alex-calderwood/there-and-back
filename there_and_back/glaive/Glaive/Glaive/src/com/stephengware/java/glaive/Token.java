package com.stephengware.java.glaive;

import com.stephengware.java.planware.ig.GoalNode;
import com.stephengware.java.planware.logic.Constant;

public class Token {

	public final StepEvent stepEvent;
	public final Constant agent;
	public final GoalNode goal;
	public final int distance;
	
	public Token(StepEvent stepEvent, Constant agent, GoalNode goal, int distance){
		this.stepEvent = stepEvent;
		this.agent = agent;
		this.goal = goal;
		this.distance = distance;
	}
	
	@Override
	public String toString(){
		String str = "[Token: ";
		str += stepEvent.source;
		str += " is ";
		str += distance;
		str += " away from ";
		str += goal.expression;
		str += " for ";
		str += agent;
		str += "]";
		return str;
	}
}
