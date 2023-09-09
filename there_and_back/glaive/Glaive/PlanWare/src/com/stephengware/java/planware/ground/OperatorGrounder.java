package com.stephengware.java.planware.ground;

import java.util.LinkedHashSet;
import java.util.Set;

import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Substitution;

public class OperatorGrounder<P extends Problem> implements ObjectGrounder<Operator, P> {

	@Override
	public Set<Object> ground(Operator operator, Grounder<P> grounder){
		LinkedHashSet<Object> grounded = new LinkedHashSet<>();
		CartesianProductBindings substitution = new CartesianProductBindings(operator.parameters, grounder);
		if(substitution.hasNext()){
			while(substitution.hasNext()){
				substitution.next();
				Object step = grounder.problem.makeStep(operator.name, getArguments(operator, substitution));
				grounded.add(step);
			}
		}
        else if(operator.precondition.isGround() && operator.effect.isGround()) {
        	Object step = grounder.problem.makeStep(operator.name);
        	grounded.add(step);
        }
        return grounded;
	}
	
	private static final Entity[] getArguments(Operator operator, Substitution bindings){
		Entity[] arguments = new Entity[operator.parameters.length];
		for(int i=0; i<arguments.length; i++)
			arguments[i] = operator.parameters.get(i).substitute(bindings);
		return arguments;
	}
}
