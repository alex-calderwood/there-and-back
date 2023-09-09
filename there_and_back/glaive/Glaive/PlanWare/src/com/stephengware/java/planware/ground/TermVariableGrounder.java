package com.stephengware.java.planware.ground;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Set;

import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.Type;

public class TermVariableGrounder<P extends Problem> implements ObjectGrounder<TermVariable, P> {

	private final HashMap<Type, LinkedHashSet<Object>> valuesByType = new HashMap<>();

	@Override
	public Set<Object> ground(TermVariable termVariable, Grounder<P> grounder){
		LinkedHashSet<Object> values = valuesByType.get(termVariable.type);
		if(values == null){
			values = new LinkedHashSet<>();
			for(Constant constant : grounder.problem.universe.getObjectsByType(termVariable.type))
				values.add(constant);
			valuesByType.put(termVariable.type, values);
		}
		return values;
	}
}
