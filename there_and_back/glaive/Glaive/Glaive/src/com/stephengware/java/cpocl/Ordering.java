package com.stephengware.java.cpocl;

public class Ordering {

	public final CPOCLStep before;
	public final CPOCLStep after;
	private int hashCode;
	
	public Ordering(CPOCLStep before, CPOCLStep after){
		this.before = before;
		this.after = after;
		this.hashCode = before.hashCode() + (after.hashCode() * 2);
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Ordering){
			Ordering otherOrdering = (Ordering) other;
			return before.equals(otherOrdering.before) && after.equals(otherOrdering.after);
		}
		else
			return false;
	}
	
	@Override
	public String toString(){
		return before + " < " + after;
	}
}
