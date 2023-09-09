package com.stephengware.java.planware.ig;

public class Motivation {

	public final IntentionNode intention;
	public final int distance;
	
	Motivation(IntentionNode intention, int distance){
		this.intention = intention;
		this.distance = distance;
	}
	
	@Override
	public int hashCode(){
		return intention.hashCode() + distance;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Motivation){
			Motivation otherMotivation = (Motivation) other;
			return intention == otherMotivation.intention && distance == otherMotivation.distance;
		}
		else
			return false;
	}
}
