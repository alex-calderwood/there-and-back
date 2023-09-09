package com.stephengware.java.glaive;

public class CausalHistoryNode {

	public final boolean valence;
	public final Event event;
	public final CausalHistoryNode previous;
	
	public CausalHistoryNode(boolean valence, Event event, CausalHistoryNode previous){
		this.valence = valence;
		this.event = event;
		this.previous = previous;
	}
}
