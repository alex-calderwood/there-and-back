package com.stephengware.java.planware;

import java.util.Iterator;

public abstract class Plan implements Cloneable {
	
	public final String name;
	public final Problem problem;
	
	public Plan(String name, Problem problem){
		this.name = name;
		this.problem = problem;
	}
	
	@Override
	public int hashCode(){
		int hashCode = 1;
		for(Step step : steps())
			hashCode = 31 * hashCode + step.hashCode();
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Plan){
			Plan otherPlan = (Plan) other;
			if(!testCompatibility(otherPlan) || !otherPlan.testCompatibility(this))
				return false;
			if(!name.equals(otherPlan.name) || countSteps() != otherPlan.countSteps())
				return false;
			Iterator<? extends Step> otherSteps = otherPlan.steps().iterator();
			for(Step step : steps())
				if(!step.equals(otherSteps.next()))
					return false;
			return true;
		}
		return false;
	}
	
	protected boolean testCompatibility(Plan other){
		return true;
	}
	
	public abstract int countSteps();
	
	public abstract Iterable<? extends Step> steps();
	
	public abstract Plan clone();
	
	@Override
	public String toString(){
		return "[Plan \"" + name + "\" for Problem \"" + problem.name + "\"]";
	}
}
