package com.stephengware.java.planware.ground;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;

import com.stephengware.java.planware.logic.BindingsObject;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.ExpressionVariable;
import com.stephengware.java.planware.logic.Term;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.Variable;

public class CartesianProductBindings extends BindingsObject {

	private final HashMap<Variable, Entity> map = new HashMap<>();
	private final Variable[] variables;
	private final Entity[][] values;
	private final int[] counters;
	private boolean hasNext = false;
	private boolean first = true;
	
	public CartesianProductBindings(Iterable<Variable> variables, Grounder<?> grounder){
		this.variables = getVariables(variables);
		this.values = new Entity[this.variables.length][];
		for(int i=0; i<this.variables.length; i++){
			this.values[i] = getValues(this.variables[i], grounder);
			if(this.values[i][0] != this.variables[i])
				this.hasNext = true;
		}
		this.counters = new int[this.variables.length];
	}
	
	private static final Variable[] getVariables(Iterable<Variable> variables){
		LinkedHashSet<Variable> vars = new LinkedHashSet<>();
		for(Iterator<Variable> iterator = variables.iterator(); iterator.hasNext();)
			vars.add(iterator.next());
		return vars.toArray(new Variable[vars.size()]);
	}
	
	private static final Entity[] getValues(Variable variable, Grounder<?> grounder){
		Set<Entity> values = grounder.ground(variable, Entity.class);
		if(values.size() == 0)
			return new Entity[]{variable};
		else
			return values.toArray(new Entity[values.size()]);
	}
	
	public boolean hasNext(){
		return hasNext;
	}
	
	public void next(){
		if(!hasNext)
			throw new IllegalStateException("Every combination of values has been exhausted.");
		if(first){
			first = false;
			for(int i=0; i<variables.length; i++)
				map.put(variables[i], values[i][0]);
		}
		else{
			int i = variables.length - 1;
			for(; i>=0; i--){
				counters[i]++;
				if(counters[i] == values[i].length){
					counters[i] = 0;
					map.put(variables[i], values[i][0]);
				}
				else{
					map.put(variables[i], values[i][counters[i]]);
					break;
				}
			}
			hasNext = !(i == 0 && counters[i] == values[i].length - 1);
		}
		hasNext = false;
		for(int i=0; i<counters.length; i++){
			if(counters[i] != values[i].length - 1){
				hasNext = true;
				break;
			}
		}
	}

	@Override
	public Term getValue(TermVariable variable){
		Entity value = map.get(variable);
		if(value == null)
			return variable;
		else
			return (Term) value;
	}

	@Override
	public Expression getValue(ExpressionVariable variable){
		Entity value = map.get(variable);
		if(value == null)
			return variable;
		else
			return (Expression) value;
	}
}
