package com.stephengware.java.glaive;

import com.stephengware.java.planware.logic.Literal;

public class CausalLink {

	public final Event tail;
	public final Literal label;
	public final Event head;
	private final int hashCode;
	
	public CausalLink(Event tail, Literal label, Event head){
		this.tail = tail;
		this.label = label;
		this.head = head;
		this.hashCode = tail.hashCode() * label.hashCode() * head.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof CausalLink){
			CausalLink otherLink = (CausalLink) other;
			return tail.equals(otherLink.tail) &&
					label.equals(otherLink.label) &&
					head.equals(otherLink.head);
		}
		return false;
	}
	
	@Override
	public String toString(){
		return tail + " -" + label + "-> " + head;
	}
}
