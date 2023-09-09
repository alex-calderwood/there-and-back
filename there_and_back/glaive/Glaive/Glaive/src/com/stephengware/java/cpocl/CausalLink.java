package com.stephengware.java.cpocl;

import com.stephengware.java.planware.logic.Literal;

public class CausalLink {

	public final CPOCLStep tail;
	public final Literal label;
	public final CPOCLStep head;
	private int hashCode;
	
	protected CausalLink(CPOCLStep tail, Literal label, CPOCLStep head){
		this.tail = tail;
		this.label = label;
		this.head = head;
		this.hashCode = tail.hashCode() + label.hashCode() + head.hashCode();
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
			CausalLink otherCL = (CausalLink) other;
			return tail.equals(otherCL.tail) && label.equals(otherCL.label) && head.equals(otherCL.head);
		}
		else
			return false;
	}
	
	@Override
	public String toString(){
		return tail + " --" + label + "-> " + head;
	}
}
