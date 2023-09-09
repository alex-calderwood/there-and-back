package com.stephengware.java.planware.ss;

import com.stephengware.java.planware.State;
import com.stephengware.java.planware.search.Node;

public abstract class StateSpaceSearchNode extends Node {
	
	public abstract State getState();
}
