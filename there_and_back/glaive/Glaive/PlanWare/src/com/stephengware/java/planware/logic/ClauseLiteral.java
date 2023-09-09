package com.stephengware.java.planware.logic;

import com.stephengware.java.planware.FormatException;

public class ClauseLiteral {

	public final Expression expression;
	public final Expression condition;
	public final Literal literal;
	
	public ClauseLiteral(Expression condition, Expression literal){
		if(condition == null)
			condition = Expression.TRUE;
		if(literal instanceof ConditionalExpression){
			ConditionalExpression condExp = (ConditionalExpression) literal;
			if(condition == Expression.TRUE)
				condition = condExp.condition;
			else
				condition = new Conjunction(condition, condExp.condition);
			literal = condExp.effect;
		}
		if(condition == Expression.TRUE)
			this.expression = literal;
		else
			this.expression = new ConditionalExpression(condition, literal);
		this.condition = condition;
		if(literal instanceof Literal)
			this.literal = (Literal) literal;
		else
			throw new FormatException("clause literal", "The expression \"" + literal + "\" is not a literal.");
	}
	
	public ClauseLiteral(Expression literal){
		this(Expression.TRUE, literal);
	}
}
