package com.stephengware.java.planware.ground;

import java.util.Set;
import java.util.TreeSet;

import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Variable;

public class EntityGrounder<I extends Entity, P extends Problem> implements ObjectGrounder<I, P> {

	@Override
	public Set<Object> ground(I entity, Grounder<P> grounder){
		TreeSet<Object> grounded = new TreeSet<Object>();
		CartesianProductBindings bindings = new CartesianProductBindings(entity.collect(Variable.class), grounder);
		while(bindings.hasNext()){
			bindings.next();
			grounded.add(entity.substitute(bindings));
		}
		return grounded;
	}
}
