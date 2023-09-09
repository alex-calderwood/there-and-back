package com.stephengware.java.planware.ground;

import java.util.LinkedHashSet;
import java.util.Set;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Substitution;

public class AxiomGrounder<P extends Problem> implements ObjectGrounder<AxiomTemplate, P> {
	
	@Override
	public Set<Object> ground(AxiomTemplate template, Grounder<P> grounder){
		LinkedHashSet<Object> grounded = new LinkedHashSet<>();
		CartesianProductBindings substitution = new CartesianProductBindings(template.parameters, grounder);
		while(substitution.hasNext()){
			substitution.next();
			grounded.add(grounder.problem.makeAxiom(indexOf(template, grounder), getArguments(template, substitution)));
		}
		return grounded;
	}
	
	private static final int indexOf(AxiomTemplate template, Grounder<?> grounder){
		for(int i=0; i<grounder.problem.domain.axioms.length; i++)
			if(grounder.problem.domain.axioms.get(i) == template)
				return i;
		return -1;
	}
	
	private static final Entity[] getArguments(AxiomTemplate template, Substitution bindings){
		Entity[] arguments = new Entity[template.parameters.length];
		for(int i=0; i<arguments.length; i++)
			arguments[i] = template.parameters.get(i).substitute(bindings);
		return arguments;
	}
}
