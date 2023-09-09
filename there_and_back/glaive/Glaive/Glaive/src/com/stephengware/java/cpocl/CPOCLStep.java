package com.stephengware.java.cpocl;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.util.ImmutableArray;
import com.stephengware.java.planware.util.ImmutableSet;

public class CPOCLStep extends IntentionalStep {

	private static final ImmutableArray<Entity> NO_ARGUMENTS = new ImmutableArray<Entity>(new Entity[0]);
	
	public final int index;
	public final boolean executed;
	
	protected CPOCLStep(int index, String name, Expression precondition, Expression effect, ImmutableSet<Constant> agents, boolean executed){
		super(null, NO_ARGUMENTS, name, precondition, effect, agents);
		this.index = index;
		this.executed = executed;
	}
	
	protected CPOCLStep(int index, IntentionalStep step, boolean executed){
		super(step.operator, step.arguments, step.precondition, step.effect, step.agents);
		this.index = index;
		this.executed = executed;
	}
	
	@Override
	public boolean equals(Object other){
		if(super.equals(other)){
			CPOCLStep otherStep = (CPOCLStep) other;
			return index == otherStep.index && executed == otherStep.executed;
		}
		else
			return false;
	}
	
	@Override
	protected boolean testCompatibility(Step other){
		return other instanceof CPOCLStep;
	}
}
