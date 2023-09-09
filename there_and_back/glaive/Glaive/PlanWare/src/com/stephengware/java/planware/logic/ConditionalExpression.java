package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.Iterator;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.util.ArrayIterator;

public class ConditionalExpression extends ExpressionObject {
	
	protected static final String CONDITION_PREDICATE = "when";
	
	public final Expression condition;
	public final Expression effect;
	private final int hashCode;
	
	public ConditionalExpression(Expression condition, Expression effect){
		if(condition == null)
			throw new FormatException(getDescription(), "Condition cannot be null.");
		if(!condition.isTestable())
			throw new FormatException(getDescription(), "Condition must be testable.");
		if(effect == null)
			throw new FormatException(getDescription(), "Effect cannot be null.");
		if(!effect.isImposable())
			throw new FormatException(getDescription(), "Effect must be imposable.");
		if(effect instanceof ConditionalExpression){
			ConditionalExpression conditionalEffect = (ConditionalExpression) effect;
			this.condition = new Conjunction(condition, conditionalEffect.condition);
			this.effect = conditionalEffect.effect;
		}
		else{
			this.condition = condition;
			this.effect = effect;
		}
		this.hashCode = CONDITION_PREDICATE.hashCode() + this.condition.hashCode() + this.effect.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof ConditionalExpression){
			ConditionalExpression otherCE = (ConditionalExpression) other;
			if(!testCompatibility(otherCE) || !otherCE.testCompatibility(this))
				return false;
			return condition.equals(otherCE.condition) && effect.equals(otherCE.effect);
		}
		return false;
	}
	
	protected boolean testCompatibility(ConditionalExpression other){
		return true;
	}
	
	@Override
	public Iterator<? extends Expression> iterator(){
		return new ArrayIterator<Expression>(condition, effect);
	}
	
	@Override
	public boolean isGround(){
		return condition.isGround() && effect.isGround();
	}
	
	@Override
	public boolean occurs(Entity entity){
		return equals(entity) || condition.occurs(entity) || effect.occurs(entity);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
		condition.collect(entityType, collection);
		effect.collect(entityType, collection);
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof ConditionalExpression){
			ConditionalExpression otherConditional = (ConditionalExpression) other;
			return condition.subsumes(otherConditional.condition, taxonomy) && effect.subsumes(otherConditional.effect, taxonomy);
		}
		return false;
	}
	
	@Override
	public Expression substitute(Substitution substitution){
		Expression substituted = substitution.substitute(this, Expression.class);
		if(this != substituted)
			return substituted;
		Expression substitutedCondition = condition.substitute(substitution);
		Expression substitutedEffect = effect.substitute(substitution);
		if(substitutedCondition == Expression.TRUE)
			return substitutedEffect.substitute(substitution);
		else if(substitutedCondition == Expression.FALSE)
			return Expression.TRUE;
		else if(substitutedCondition == condition && substitutedEffect == effect)
			return this;
		else
			return new ConditionalExpression(substitutedCondition, substitutedEffect).substitute(substitution);
	}
	
	@Override
	public boolean isTestable(){
		return false;
	}
	
	@Override
	public boolean test(State state){
		throw new UnsupportedOperationException("A " + getDescription() + " is not testable.");
	}
	
	@Override
	public boolean isImposable(){
		return true;
	}
	
	@Override
	public boolean impose(State state){
		if(condition.test(state))
			return effect.impose(state);
		else
			return false;
	}

	@Override
	public ConditionalExpression negate(){
		return new ConditionalExpression(condition, effect.negate());
	}
	
	@Override
	public ConditionalExpression toCNF(){
		if(NormalFormUtilities.isCNF(this))
			return this;
		else
			return new ConditionalExpression(condition, effect.toCNF());
	}

	@Override
	public Expression toDNF(){
		if(NormalFormUtilities.isDNF(this))
			return this;
		else
			return new ConditionalExpression(condition, effect.toDNF());
	}
	
	@Override
	public String toString(){
		return "(" + CONDITION_PREDICATE + " " + condition + " " + effect + ")";
	}
	
	@Override
	public String getDescription(){
		return "conditional expression";
	}
}
