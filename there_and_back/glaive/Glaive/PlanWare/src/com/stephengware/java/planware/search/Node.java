package com.stephengware.java.planware.search;

import com.stephengware.java.planware.Plan;

public abstract class Node {

	private static int nextID = 0;
	public final int id;
	boolean visited = false;
	
	public Node(){
		this.id = nextID;
		nextID++;
	}
	
	public abstract Plan getPlan();
}
