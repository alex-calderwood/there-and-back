package com.stephengware.java.planware.logic;

import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.util.ImmutableArray;

public class ExistentialQuantification extends QuantifiedExpression {
	
	protected static final String EXISTENTIAL_QUANTIFIER = "exists";
	
	public ExistentialQuantification(TermVariable variable, Expression argument){
		super(EXISTENTIAL_QUANTIFIER, variable, argument);
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
			return new ExistentialQuantification((TermVariable) substitutedVariable, substitutedArgument).substitute(substitution);
	}
	
	@Override
	public boolean isImposable(){
		return false;
	}
	
	@Override
	public UniversalQuantification negate(){
		return new UniversalQuantification(variable, argument.negate());
	}
	
	@Override
	public ExistentialQuantification toCNF(){
		if(NormalFormUtilities.isCNF(this))
			return this;
		else
			return new ExistentialQuantification(variable, argument.toCNF());
	}

	@Override
	public ExistentialQuantification toDNF(){
		if(NormalFormUtilities.isDNF(this))
			return this;
		else
			return new ExistentialQuantification(variable, argument.toDNF());
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
		for(int i=0; i<objects.length; i++){
			substitution.setValue(objects.get(i));
			expressions[i] = argument.substitute(substitution);
		}
		return new Disjunction(expressions);
	}
	
	@Override
	public ExistentialQuantification standardize(){
		TermVariable newVariable = variable.newInstance();
		SingleVariableSubstitution substitution = new SingleVariableSubstitution();
		substitution.setValue(newVariable);
		return new ExistentialQuantification(newVariable, argument.substitute(substitution));
	}
	
	@Override
	public String getDescription(){
		return "existential quantification";
	}
}
