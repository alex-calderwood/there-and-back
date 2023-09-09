package com.stephengware.java.planware;

import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionalDomain extends Domain {

	public final ImmutableSet<IntentionalOperator> operators;
	
	public IntentionalDomain(String name, Universe universe, ImmutableSet<IntentionalOperator> operators, ImmutableSet<AxiomTemplate> axioms){
		super(name, universe, new ImmutableSet<Operator>(operators.toArray()), axioms);
		this.operators = operators;
	}
	
	public IntentionalDomain(String name, Universe universe, IntentionalOperator[] operators, AxiomTemplate[] axioms){
		this(name, universe, new ImmutableSet<IntentionalOperator>(operators), new ImmutableSet<AxiomTemplate>(axioms));
	}
	
	@Override
	public IntentionalOperator getOperator(String name){
		return (IntentionalOperator) super.getOperator(name);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public IntentionalDomain substitute(Substitution substitution){
		boolean different = false;
		Universe universe = this.universe.substitute(substitution);
		if(universe != this.universe)
			different = true;
		ImmutableSet<IntentionalOperator> operators = (ImmutableSet<IntentionalOperator>) substituteOperators(substitution);
		if(operators != this.operators)
			different = true;
		ImmutableSet<AxiomTemplate> axioms = (ImmutableSet<AxiomTemplate>) substituteAxioms(substitution);
		if(axioms != this.axioms)
			different = true;
		if(different)
			return new IntentionalDomain(name, universe, operators, axioms);
		else
			return this;
	}
	
	@Override
	protected ImmutableSet<? extends IntentionalOperator> substituteOperators(Substitution substitution){
		boolean different = false;
		IntentionalOperator[] operators = new IntentionalOperator[this.operators.length];
		for(int i=0; i<operators.length; i++){		
			operators[i] = this.operators.get(i).substitute(substitution);
			if(operators[i] != this.operators.get(i))
				different = true;
		}
		if(different)
			return new ImmutableSet<>(operators);
		else
			return this.operators;
	}
}
