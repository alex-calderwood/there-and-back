package com.stephengware.java.planware.logic;

import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.util.ImmutableArray;

public class UniversalQuantification extends QuantifiedExpression {
	
	protected static final String UNIVERSAL_QUANTIFIER = "forall";
	
	public UniversalQuantification(TermVariable variable, Expression argument){
		super(UNIVERSAL_QUANTIFIER, variable, argument);
	}
	
	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(this != substituted)
			return substituted;
		Term substitutedVariable = variable.substitute(substitution);
		if(!(substitutedVariable instanceof TermVariable))
			throw new IllegalArgumentException("The " + substitutedVariable.getDescription() + " + \"" + substitutedVariable + "\" cannot be substituted for the quantified variable \"" + variable + "\" in \"" + this + "\".");
		Expression substitutedArgument = argument.substitute(substitution);
		if(substitutedArgument == Expression.TRUE)
			return Expression.TRUE;
		else if(substitutedArgument == Expression.FALSE)
			return Expression.FALSE;
		else if(variable == substitutedVariable && argument == substitutedArgument)
			return this;
		else
			return new UniversalQuantification((TermVariable) substitutedVariable, substitutedArgument).substitute(substitution);
	}
	
	@Override
	public boolean isImposable(){
		return true;
	}
	
	@Override
	public ExistentialQuantification negate(){
		return new ExistentialQuantification(variable, argument.negate());
	}
	
	@Override
	public UniversalQuantification toCNF(){
		if(NormalFormUtilities.isCNF(this))
			return this;
		else
			return new UniversalQuantification(variable, argument.toCNF());
	}

	@Override
	public UniversalQuantification toDNF(){
		if(NormalFormUtilities.isDNF(this))
			return this;
		else
			return new UniversalQuantification(variable, argument.toDNF());
	}

	@Override
	public Expression toUniversalBase(Universe universe){
		ImmutableArray<Constant> objects = universe.getObjectsByType(variable.type);
		if(objects.length == 0)
			return Expression.TRUE;
		SingleVariableSubstitution substitution = new SingleVariableSubstitution();
		if(objects.length == 1){
			substitution.setValue(objects.get(0));
			return argument.substitute(substitution);
		}
		Expression[] expressions = new Expression[objects.length];
		int i=0;
		for(Constant object : objects){
			substitution.setValue(object);
			expressions[i] = argument.substitute(substitution);
			i++;
		}
		return new Conjunction(expressions);
	}
	
	@Override
	public UniversalQuantification standardize(){
		TermVariable newVariable = variable.newInstance();
		SingleVariableSubstitution substitution = new SingleVariableSubstitution();
		substitution.setValue(newVariable);
		return new UniversalQuantification(newVariable, argument.substitute(substitution));
	}
	
	@Override
	public String getDescription(){
		return "universal quantification";
	}
}
