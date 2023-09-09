package com.stephengware.java.planware.logic;

import java.util.LinkedList;

public final class NormalFormUtilities {
	
	public static final boolean isCNF(Expression expression){
		if(expression instanceof QuantifiedExpression)
			return isCNF(((QuantifiedExpression) expression).argument);
		else if(expression instanceof ConditionalExpression)
			return isCNF(((ConditionalExpression) expression).effect);
		else if(isDisjunctiveClause(expression))
			return true;
		else if(expression instanceof Conjunction){
			for(Expression argument : ((Conjunction) expression).arguments)
				if(!isDisjunctiveClause(argument))
					return false;
			return true;
		}
		else
			return false;
	}
	
	public static final boolean isDisjunctiveClause(Expression expression){
		if(expression instanceof QuantifiedExpression)
			return isDisjunctiveClause(((QuantifiedExpression) expression).argument);
		else if(expression instanceof ConditionalExpression)
			return isDisjunctiveClause(((ConditionalExpression) expression).effect);
		else if(expression instanceof Literal)
			return true;
		else if(expression instanceof Disjunction){
			for(Expression argument : ((Disjunction) expression).arguments)
				if(!isLiteral(argument) && !isDisjunctiveClause(argument))
					return false;
			return true;
		}
		else
			return false;
	}
	
	public static final boolean isDNF(Expression expression){
		if(expression instanceof QuantifiedExpression)
			return isDNF(((QuantifiedExpression) expression).argument);
		else if(expression instanceof ConditionalExpression)
			return isDNF(((ConditionalExpression) expression).effect);
		else if(isConjunctiveClause(expression))
			return true;
		else if(expression instanceof Disjunction){
			for(Expression argument : ((Disjunction) expression).arguments)
				if(!isConjunctiveClause(argument))
					return false;
			return true;
		}
		else
			return false;
	}
	
	public static final boolean isConjunctiveClause(Expression expression){
		if(expression instanceof QuantifiedExpression)
			return isConjunctiveClause(((QuantifiedExpression) expression).argument);
		else if(expression instanceof ConditionalExpression)
			return isConjunctiveClause(((ConditionalExpression) expression).effect);
		else if(expression instanceof Literal)
			return true;
		else if(expression instanceof Conjunction){
			for(Expression argument : ((Conjunction) expression).arguments)
				if(!isLiteral(argument) && !isConjunctiveClause(argument))
					return false;
			return true;
		}
		else
			return false;
	}
	
	public static final boolean isLiteral(Expression expression){
		if(expression instanceof QuantifiedExpression)
			return isLiteral(((QuantifiedExpression) expression).argument);
		else if(expression instanceof ConditionalExpression)
			return isLiteral(((ConditionalExpression) expression).effect);
		else
			return expression instanceof Literal;
	}
	
	private static abstract class NAryBooleanExpressionBuilder<B extends NAryBooleanExpression> {
		
		public abstract B makeExpression(Expression[] arguments);
		
		public B makeExpression(java.util.List<Expression> arguments){
			return makeExpression(arguments.toArray(new Expression[arguments.size()]));
		}
	}
	
	private static final NAryBooleanExpressionBuilder<Disjunction> DISJUNCTION_BUILDER = new NAryBooleanExpressionBuilder<Disjunction>(){

		@Override
		public Disjunction makeExpression(Expression[] arguments){
			return new Disjunction(arguments);
		}
	};
	
	private static final NAryBooleanExpressionBuilder<Conjunction> CONJUNCTION_BUILDER = new NAryBooleanExpressionBuilder<Conjunction>(){

		@Override
		public Conjunction makeExpression(Expression[] arguments){
			return new Conjunction(arguments);
		}
	};
	
	static final Expression toCNF(Conjunction conjunction){
		if(isCNF(conjunction))
			return conjunction;
		Expression[] cnfArguments = new Expression[conjunction.arguments.length];
		for(int i=0; i<cnfArguments.length; i++)
			cnfArguments[i] = conjunction.arguments.get(i).toCNF();
		return new Conjunction(cnfArguments);
	}
	
	static final Expression toCNF(Disjunction disjunction){
		if(isCNF(disjunction))
			return disjunction;
		Expression[] cnfArguments = new Expression[disjunction.arguments.length];
		for(int i=0; i<cnfArguments.length; i++)
			cnfArguments[i] = disjunction.arguments.get(i).toCNF();
		return permuteArguments(cnfArguments, Conjunction.class, CONJUNCTION_BUILDER, DISJUNCTION_BUILDER);
	}
	
	static final Expression toDNF(Conjunction conjunction){
		if(isDNF(conjunction))
			return conjunction;
		Expression[] dnfArguments = new Expression[conjunction.arguments.length];
		for(int i=0; i<dnfArguments.length; i++)
			dnfArguments[i] = conjunction.arguments.get(i).toDNF();
		return permuteArguments(dnfArguments, Disjunction.class, DISJUNCTION_BUILDER, CONJUNCTION_BUILDER);
	}
	
	static final Expression toDNF(Disjunction disjunction){
		if(isDNF(disjunction))
			return disjunction;
		Expression[] dnfArguments = new Expression[disjunction.arguments.length];
		for(int i=0; i<dnfArguments.length; i++)
			dnfArguments[i] = disjunction.arguments.get(i).toDNF();
		return new Disjunction(dnfArguments);
	}
	
	private static final <A extends NAryBooleanExpression, C extends NAryBooleanExpression> Expression permuteArguments(Expression[] arguments, Class<A> argumentType, NAryBooleanExpressionBuilder<A> expressionBuilder, NAryBooleanExpressionBuilder<C> clauseBuilder){
		int clauseCount = 1;
		for(Expression argument : arguments)
			clauseCount *= length(argument);
		int[] counters = new int[arguments.length];
		LinkedList<Expression> clauses = new LinkedList<>();
		for(int i=0; i<clauseCount; i++){
			clauses.add(makeClause(arguments, counters, argumentType, clauseBuilder));
			int c = counters.length - 1;
			while(c >= 0){
				counters[c]++;
				if(counters[c] >= length(arguments[c])){
					counters[c] = 0;
					c--;
				}
				else
					break;
			}
		}
		if(clauses.size() == 1)
			return clauses.get(0);
		else
			return expressionBuilder.makeExpression(clauses);
	}
	
	private static final int length(Expression expression){
		if(expression instanceof QuantifiedExpression)
			return length(((QuantifiedExpression) expression).argument);
		else if(expression instanceof ConditionalExpression)
			return length(((ConditionalExpression) expression).effect);
		else if(expression instanceof NAryBooleanExpression)
			return ((NAryBooleanExpression) expression).arguments.length;
		else
			return 1;
	}
	
	private static abstract class Prefix {}
	
	private static final class UniversalQuantificationPrefix extends Prefix {
		
		public final TermVariable variable;
		
		public UniversalQuantificationPrefix(TermVariable variable){
			this.variable = variable;
		}
	}
	
	private static final class ExistentialQuantificationPrefix extends Prefix {
		
		public final TermVariable variable;
		
		public ExistentialQuantificationPrefix(TermVariable variable){
			this.variable = variable;
		}
	}
	
	private static final class ConditionPrefix extends Prefix {
		
		public final Expression condition;
		
		public ConditionPrefix(Expression condition){
			this.condition = condition;
		}
	}

	private static final <A extends NAryBooleanExpression, C extends NAryBooleanExpression> Expression makeClause(Expression[] arguments, int[] counters, Class<A> argumentType, NAryBooleanExpressionBuilder<C> clauseBuilder){
		LinkedList<Prefix> prefixes = new LinkedList<>();
		LinkedList<Expression> literals = new LinkedList<Expression>();
		for(int i=0; i<arguments.length; i++){
			Expression argument = arguments[i];
			if(isLiteral(argument)){
				literals.add(argument);
				continue;
			}
			argument = stripPrefixes(argument, prefixes);
			Expression clause = argument;
			if(argumentType.isAssignableFrom(argument.getClass())){
				NAryBooleanExpression booleanArgument = (NAryBooleanExpression) argument;
				clause = booleanArgument.arguments.get(counters[i]);
			}
			if(isLiteral(clause)){
				literals.add(clause);
				continue;
			}
			clause = stripPrefixes(clause, prefixes);
			NAryBooleanExpression booleanClause = (NAryBooleanExpression) clause;
			for(int j=0; j<booleanClause.arguments.length; j++)
				literals.add(booleanClause.arguments.get(j));
		}
		Expression newClause;
		if(literals.size() == 1)
			newClause = literals.get(0);
		else
			newClause = clauseBuilder.makeExpression(literals);
		return addPrefixes(newClause, prefixes);
	}
	
	private static final Expression stripPrefixes(Expression expression, LinkedList<Prefix> prefixes){
		if(expression instanceof UniversalQuantification){
			UniversalQuantification universalExpression = ((UniversalQuantification) expression).standardize();
			prefixes.add(new UniversalQuantificationPrefix(universalExpression.variable));
			return stripPrefixes(universalExpression.argument, prefixes);
		}
		else if(expression instanceof ExistentialQuantification){
			ExistentialQuantification existentialExpression = ((ExistentialQuantification) expression).standardize();
			prefixes.add(new ExistentialQuantificationPrefix(existentialExpression.variable));
			return stripPrefixes(existentialExpression.argument, prefixes);
		}
		else if(expression instanceof ConditionalExpression){
			ConditionalExpression conditionalExpression = (ConditionalExpression) expression;
			prefixes.add(new ConditionPrefix(conditionalExpression.condition));
			return stripPrefixes(conditionalExpression.effect, prefixes);
		}
		else
			return expression;
	}
	
	private static final Expression addPrefixes(Expression expression, LinkedList<Prefix> prefixList){
		Prefix[] prefixes = prefixList.toArray(new Prefix[prefixList.size()]);
		for(int i=prefixes.length-1; i>=0; i--){
			if(prefixes[i].getClass() == UniversalQuantificationPrefix.class){
				UniversalQuantificationPrefix universalPrefix = (UniversalQuantificationPrefix) prefixes[i];
				if(expression.occurs(universalPrefix.variable))
					expression = new UniversalQuantification(universalPrefix.variable, expression);
			}
			else if(prefixes[i].getClass() == ExistentialQuantificationPrefix.class){
				ExistentialQuantificationPrefix existentialPrefix = (ExistentialQuantificationPrefix) prefixes[i];
				if(expression.occurs(existentialPrefix.variable))
					expression = new ExistentialQuantification(existentialPrefix.variable, expression);
			}
			else{
				ConditionPrefix conditionPrefix = (ConditionPrefix) prefixes[i];
				expression = new ConditionalExpression(conditionPrefix.condition, expression);
			}
		}
		return expression;
	}
}
