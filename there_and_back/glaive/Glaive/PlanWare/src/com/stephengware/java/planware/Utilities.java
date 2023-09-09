package com.stephengware.java.planware;

import java.util.LinkedList;

import com.stephengware.java.planware.logic.ClauseIterator;
import com.stephengware.java.planware.logic.ClauseLiteral;
import com.stephengware.java.planware.logic.DNFIterator;
import com.stephengware.java.planware.logic.Expression;

public class Utilities {

	public static final Clause[] getPreconditionClauses(String objectDescription, Expression expression){
		if(!expression.isTestable())
			throw new FormatException(objectDescription, "The expression \"" + expression + "\" is not testable.");
		if(!expression.isGround())
			throw new FormatException(objectDescription, "The expression \"" + expression + "\" is not ground.");
		LinkedList<Clause> clauses = new LinkedList<>();
		for(DNFIterator clauseIterator = new DNFIterator(expression); clauseIterator.hasNext();)
			clauses.add(new Clause(clauseIterator.next()));
		return clauses.toArray(new Clause[clauses.size()]);
	}
	
	public static final Effect[] getEffectLiterals(String objectDescription, Expression expression){
		if(!expression.isImposable())
			throw new FormatException(objectDescription, "The expression \"" + expression + "\" is not imposable.");
		if(!expression.isGround())
			throw new FormatException(objectDescription, "The expression \"" + expression + "\" is not ground.");
		LinkedList<Effect> effects = new LinkedList<>();
		DNFIterator clauseIterator = new DNFIterator(expression);
		if(clauseIterator.hasNext()){
			for(ClauseIterator literalIterator = clauseIterator.next(); literalIterator.hasNext();){
				ClauseLiteral literal = literalIterator.next();
				effects.add(new Effect(literal.expression, literal.condition, literal.literal));
			}
		}
		if(clauseIterator.hasNext())
			throw new NonDeterministicException(expression);
		return effects.toArray(new Effect[effects.size()]);
	}
}
