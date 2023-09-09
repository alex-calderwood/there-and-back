package com.stephengware.java.planware.ground;

import java.util.Set;

import com.stephengware.java.planware.Problem;

public interface ObjectGrounder<I, P extends Problem> {
		
	public Set<Object> ground(I input, Grounder<P> grounder);
}
