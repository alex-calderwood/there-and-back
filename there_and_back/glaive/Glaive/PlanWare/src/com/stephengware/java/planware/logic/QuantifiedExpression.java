package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.Iterator;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.util.ArrayIterator;

public abstract class QuantifiedExpression extends ExpressionObject {
		
	public final String quantifier;
	public final TermVariable variable;
	public final Expression argument;
	private final int hashCode;
	
	protected QuantifiedExpression(String quantifier, TermVariable variable, Expression argument){
		this.quantifier = quantifier.intern();
		if(variable == null)
			throw new FormatException(getDescription(), "Variable cannot be null.");
		this.variable = variable;
		if(argument == null)
			throw new FormatException(getDescription(), "Argument cannot be null.");
		if(!argument.occurs(variable))
			throw new FormatException(getDescription(), "Variable does not occur in the argument.");
		this.argument = argument;
		this.hashCode = quantifier.hashCode() + variable.hashCode() + argument.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return false;
		else if(other instanceof QuantifiedExpression){
			QuantifiedExpression otherQuantifiedExpression = (QuantifiedExpression) other;
			if(!testCompatibility(otherQuantifiedExpression) || !otherQuantifiedExpression.testCompatibility(this))
				return false;
			return quantifier == otherQuantifiedExpression.quantifier &&
				variable.equals(otherQuantifiedExpression.variable) &&
				argument.equals(otherQuantifiedExpression.argument);
		}
		return false;
	}
	
	protected boolean testCompatibility(QuantifiedExpression other){
		return true;
	}
	
	@Override
	public Iterator<? extends Entity> iterator(){
		return new ArrayIterator<Entity>(variable, argument);
	}
	
	@Override
	public boolean isGround(){
		return false;
	}
	
	@Override
	public boolean occurs(Entity entity){
		return equals(entity) || variable.occurs(entity) || argument.occurs(entity);
	}
		
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
		variable.collect(entityType, collection);
		argument.collect(entityType, collection);
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof QuantifiedExpression){
			QuantifiedExpression otherQuantifiedExpression = (QuantifiedExpression) other;
			return quantifier == otherQuantifiedExpression.quantifier && variable.subsumes(otherQuantifiedExpression.variable, taxonomy) && argument.subsumes(otherQuantifiedExpression.argument, taxonomy);
		}
		return false;
	}
		
	@Override
	public boolean isTestable(){
		return true;
	}
	
	@Override
	public boolean test(State state){
		throw new UnsupportedOperationException("Cannot test " + getDescription() + "; the possible variable bindings are not known.");
	}
	
	@Override
	public boolean impose(State state){
		throw new UnsupportedOperationException("Cannot impose " + getDescription() + "; the possible variable bindings are not known.");
	}
	
	@Override
	public abstract QuantifiedExpression toCNF();

	@Override
	public abstract QuantifiedExpression toDNF();
	
	protected class SingleVariableSubstitution extends SubstitutionObject {

		private Term value = null;
		
		public void setValue(Term value){
			this.value = value;
		}

		@Override
		protected Entity substitute(Entity entity){
			if(entity == variable)
				return value;
			else
				return entity;
		}
	}
	
	public abstract Expression toUniversalBase(Universe universe);
	
	public abstract QuantifiedExpression standardize();
	
	@Override
	public String toString(){
		return "(" + quantifier + " (" + variable + " - " + variable.type + ") " + argument + ")";
	}
	
	@Override
	public String getDescription(){
		return "quantified expression";
	}
}
