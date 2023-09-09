package com.stephengware.java.glaive;

import com.stephengware.java.planware.Clause;
import com.stephengware.java.planware.Effect;
import com.stephengware.java.planware.util.ImmutableArray;

public abstract class Event {

	public final Object source;
	public final int time;
	public final ImmutableArray<CausalLink> inLinks;
	
	protected Event(Object source, int time, ImmutableArray<Clause> preconditions, ImmutableArray<Effect> effects, CausalState state){
		this.source = source;
		this.time = time;
		this.inLinks = state.getCausalLinks(preconditions, effects, this);
	}
	
	protected Event(Object source, int time, ImmutableArray<CausalLink> inLinks){
		this.source = source;
		this.time = time;
		this.inLinks = inLinks;
	}
	
	@Override
	public int hashCode(){
		return source.hashCode();
	}
	
	@Override
	public boolean equals(Object other){
		return this == other;
	}
	
	@Override
	public String toString(){
		return "[Event: " + source + " at time " + time + "]";
	}
}
