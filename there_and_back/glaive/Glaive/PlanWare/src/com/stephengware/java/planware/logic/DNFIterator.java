package com.stephengware.java.planware.logic;

import java.util.Iterator;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.util.ArrayIterator;
import com.stephengware.java.planware.util.EmptyIterator;

public class DNFIterator implements Iterator<ClauseIterator> {

	public final Expression dnfExpression;
	private final Expression condition;
	private final Iterator<Expression> clauses;
	
	public DNFIterator(Expression expression){
		expression = expression.toDNF();
		this.dnfExpression = expression;
		if(dnfExpression instanceof ConditionalExpression){
			ConditionalExpression condExp = (ConditionalExpression) expression;
			this.condition = condExp.condition;
			expression = condExp.effect;
		}
		else
			this.condition = Expression.TRUE;
		if(expression instanceof Disjunction)
			this.clauses = ((Disjunction) expression).arguments.iterator();
		else if(expression instanceof Conjunction || expression instanceof Literal)
			this.clauses = new ArrayIterator<Expression>(new Expression[]{expression});
		else if(expression == Expression.TRUE || expression == Expression.FALSE)
			this.clauses = new EmptyIterator<Expression>();
		else
			throw new FormatException("DNF iterator", "The expression \"" + expression + "\" is not a disjunction, conjunctive clause, or literal.");
	}

	@Override
	public boolean hasNext(){
		return clauses.hasNext();
	}

	@Override
	public ClauseIterator next(){
		return new ClauseIterator(condition, clauses.next());
	}

	@Override
	public void remove(){
		clauses.remove();
	}
}
