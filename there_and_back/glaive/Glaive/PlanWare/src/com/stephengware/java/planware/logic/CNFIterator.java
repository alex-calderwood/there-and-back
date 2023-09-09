package com.stephengware.java.planware.logic;

import java.util.Iterator;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.util.ArrayIterator;
import com.stephengware.java.planware.util.EmptyIterator;

public class CNFIterator implements Iterator<ClauseIterator> {

	public final Expression cnfExpression;
	private final Expression condition;
	private final Iterator<Expression> clauses;
	
	public CNFIterator(Expression expression){
		expression = expression.toCNF();
		this.cnfExpression = expression;
		if(expression instanceof ConditionalExpression){
			ConditionalExpression condExp = (ConditionalExpression) expression;
			this.condition = condExp.condition;
			expression = condExp.effect;
		}
		else
			this.condition = Expression.TRUE;
		if(expression instanceof Conjunction)
			this.clauses = ((Conjunction) expression).arguments.iterator();
		else if(expression instanceof Disjunction || expression instanceof Literal)
			this.clauses = new ArrayIterator<Expression>(new Expression[]{expression});
		else if(expression == Expression.TRUE || expression == Expression.FALSE)
			this.clauses = new EmptyIterator<Expression>();
		else
			throw new FormatException("CNF iterator", "The expression \"" + expression + "\" is not a conjunction, disjunctive clause, or literal.");
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
