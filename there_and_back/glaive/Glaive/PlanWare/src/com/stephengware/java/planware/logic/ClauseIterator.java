package com.stephengware.java.planware.logic;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.util.ArrayIterator;

public class ClauseIterator implements Iterator<ClauseLiteral> {

	public final Expression clause;
	private final Expression condition;
	private final Iterator<Expression> literals;
	
	public ClauseIterator(Expression condition, Expression clause){
		if(condition == null)
			condition = Expression.TRUE;
		if(clause instanceof ConditionalExpression){
			ConditionalExpression condExp = (ConditionalExpression) clause;
			if(condition == Expression.TRUE){
				condition = condExp.condition;
				this.clause = clause;
			}
			else{
				condition = new Conjunction(condition, condExp.condition);
				this.clause = new ConditionalExpression(condition, condExp.effect);
			}
			clause = condExp.effect;
		}
		else
			this.clause = clause;
		this.condition = condition;
		if(clause instanceof NAryBooleanExpression){
			ArrayList<Expression> literals = new ArrayList<>();
			collectLiterals(Expression.TRUE, clause, literals);
			this.literals = literals.iterator();
		}
		else if(clause instanceof Literal)
			this.literals = new ArrayIterator<Expression>(new Expression[]{clause});
		else
			throw new FormatException("clause iterator", "The expression \"" + clause + "\" is not a conjunctive clause, disjunctive caluse, or literal.");
	}
	
	private static final void collectLiterals(Expression condition, Expression expression, Collection<Expression> literals){
		if(expression instanceof ConditionalExpression){
			ConditionalExpression condExp = (ConditionalExpression) expression;
			if(condition == Expression.TRUE)
				collectLiterals(condExp.condition, condExp.effect, literals);
			else
				collectLiterals(new Conjunction(condition, condExp.condition), condExp.effect, literals);
		}
		else if(expression instanceof Literal){
			if(condition == Expression.TRUE)
				literals.add(expression);
			else
				literals.add(new ConditionalExpression(condition, expression));
		}
		else if(expression instanceof NAryBooleanExpression){
			for(Expression argument : ((NAryBooleanExpression) expression).arguments)
				collectLiterals(condition, argument, literals);
		}
	}
	
	public ClauseIterator(Expression clause){
		this(Expression.TRUE, clause);
	}

	@Override
	public boolean hasNext(){
		return literals.hasNext();
	}

	@Override
	public ClauseLiteral next(){
		return new ClauseLiteral(condition, literals.next());
	}

	@Override
	public void remove(){
		literals.remove();
	}
}
