package com.stephengware.java.planware.io.pddl;

import java.util.Iterator;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.DocumentParser;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.IOManager;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.ConditionalExpression;
import com.stephengware.java.planware.logic.Conjunction;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Negation;
import com.stephengware.java.planware.logic.Predication;
import com.stephengware.java.planware.util.ImmutableList;

public class PDDLManager extends IOManager<SExpression, SExpression> {

	public static final String DEFINITION_KEYWORD = "define";
	public static final String REQUIREMENTS_IDENTIFIER = ":requirements";
	
	private static final DocumentParser<SExpression> NODE_SEQUENCE_PARSER = new NodeSequenceParser();
	private static final Extension<SExpression, SExpression> DOMAIN_EXTENSION = new DomainExtension();
	private static final Extension<SExpression, SExpression> PROBLEM_EXTENSION = new ProblemExtension();
	private static final Extension<SExpression, SExpression> UNIVERSE_EXTENSION = new UniverseExtension();
	private static final Extension<SExpression, SExpression> PLAN_EXTENSION = new PlanExtension();
	private static final Extension<SExpression, SExpression> STEP_EXTENSION = new StepExtension();
	private static final Extension<SExpression, SExpression> STATE_SPACE_EXTENSION = new StateSpaceExtension();
	private static final Extension<SExpression, SExpression> PREDICATION_EXTENSION = new PredicationExtension();
	private static final Extension<SExpression, SExpression> TERM_EXTENSION = new TermExtension();
	private static final Extension<SExpression, SExpression> CONSTANT_EXTENSION = new ConstantExtension();
	private static final Extension<SExpression, SExpression> VARIABLE_EXTENSION = new VariableExtension();
	private static final Extension<SExpression, SExpression> TERM_VARIABLE_EXTENSION = new TermVariableExtension();
	private static final Extension<SExpression, SExpression> NEGATION_EXTENSION = new NegationExtension();
	private static final Extension<SExpression, SExpression> NEGATED_LITERAL_EXTENSION = new NegatedLiteralExtension();
	private static final Extension<SExpression, SExpression> CONJUNCTION_EXTENSION = new ConjunctionExtension();
	private static final Extension<SExpression, SExpression> DISJUNCTION_EXTENSION = new DisjunctionExtension();
	
	public PDDLManager(){
		super(com.stephengware.java.planware.io.pddl.sexp.DocumentReader.DOCUMENT_READER, com.stephengware.java.planware.io.pddl.sexp.DocumentWriter.DOCUMENT_WRITER);
		parser.addDocumentParser(Node[].class, NODE_SEQUENCE_PARSER);
		ImmutableList<Class<? extends Expression>> goalExpressions = new ImmutableList<>();
		goalExpressions = goalExpressions.add(Predication.class);
		goalExpressions = goalExpressions.add(Conjunction.class);
		parser.defineObject(GOAL_EXPRESSIONS_LIST, goalExpressions);
		ImmutableList<Class<? extends Expression>> effectExpressions = new ImmutableList<>();
		effectExpressions = effectExpressions.add(Predication.class);
		effectExpressions = effectExpressions.add(Negation.class);
		effectExpressions = effectExpressions.add(Conjunction.class);
		parser.defineObject(EFFECT_EXPRESSIONS_LIST, effectExpressions);
		install(DOMAIN_EXTENSION);
		install(PROBLEM_EXTENSION);
		install(UNIVERSE_EXTENSION);
		install(PLAN_EXTENSION);
		install(STEP_EXTENSION);
		install(STATE_SPACE_EXTENSION);
		install(PREDICATION_EXTENSION);
		install(TERM_EXTENSION);
		install(CONSTANT_EXTENSION);
		install(VARIABLE_EXTENSION);
		install(TERM_VARIABLE_EXTENSION);
		install(NEGATION_EXTENSION);
		install(NEGATED_LITERAL_EXTENSION);
		install(CONJUNCTION_EXTENSION);
		install(DISJUNCTION_EXTENSION);
	}
	
	private static final String GOAL_EXPRESSIONS_LIST = "PDDLManager#goalExpressions";
	
	@SuppressWarnings("unchecked")
	public static final void allowGoalType(Class<? extends Expression> expressionType, Parser<SExpression> parser){
		ImmutableList<Class<? extends Expression>> goalExpressionsList = parser.getDefinedObject(GOAL_EXPRESSIONS_LIST, ImmutableList.class);
		if(goalExpressionsList == null)
			goalExpressionsList = new ImmutableList<>();
		parser.defineObject(GOAL_EXPRESSIONS_LIST, goalExpressionsList.add(expressionType));
	}
	
	@SuppressWarnings("unchecked")
	public static final Expression parseGoal(SExpression document, Parser<SExpression> parser) throws ParseException {
		Expression goal = parser.parseOrFail(document, Expression.class);
		ImmutableList<Class<? extends Expression>> allowedList = parser.getDefinedObject(PDDLManager.GOAL_EXPRESSIONS_LIST, ImmutableList.class);
		if(!isAllowedGoal(goal, allowedList))
			throw new ParseException(document, "The " + goal.getDescription() + " \"" + goal + "\" is not allowed to appear in a goal expression.");
		return goal;
	}
	
	private static final boolean isAllowedGoal(Expression expression, ImmutableList<Class<? extends Expression>> allowedList){
		boolean inList = false;
		for(Class<? extends Expression> allowed : allowedList){
			if(allowed.isAssignableFrom(expression.getClass())){
				inList = true;
				break;
			}
		}
		if(!inList)
			return false;
		for(Iterator<? extends Entity> iterator = expression.iterator(); iterator.hasNext();){
			Entity entity = iterator.next();
			if(entity instanceof Expression && !isAllowedGoal((Expression) entity, allowedList))
				return false;
		}
		return true;
	}

	private static final String EFFECT_EXPRESSIONS_LIST = "PDDLManager#effectExpressions";
	
	@SuppressWarnings("unchecked")
	public static final void allowEffectType(Class<? extends Expression> expressionType, Parser<SExpression> parser){
		ImmutableList<Class<? extends Expression>> effectExpressionsList = parser.getDefinedObject(EFFECT_EXPRESSIONS_LIST, ImmutableList.class);
		if(effectExpressionsList == null)
			effectExpressionsList = new ImmutableList<>();
		parser.defineObject(EFFECT_EXPRESSIONS_LIST, effectExpressionsList.add(expressionType));
	}
	
	@SuppressWarnings("unchecked")
	public static final Expression parseEffect(SExpression document, Parser<SExpression> parser) throws ParseException {
		Expression effect = parser.parseOrFail(document, Expression.class);
		ImmutableList<Class<? extends Expression>> allowedList = parser.getDefinedObject(PDDLManager.EFFECT_EXPRESSIONS_LIST, ImmutableList.class);
		if(!isAllowedEffect(effect, allowedList))
			throw new ParseException(document, "The " + effect.getDescription() + " \"" + effect + "\" is not allowed to appear in an effect expression.");
		return effect;
	}
	
	private static final boolean isAllowedEffect(Expression expression, ImmutableList<Class<? extends Expression>> allowedList){
		if(expression instanceof ConditionalExpression)
			return isAllowedEffect(((ConditionalExpression) expression).effect, allowedList);
		boolean inList = false;
		for(Class<? extends Expression> allowed : allowedList){
			if(allowed.isAssignableFrom(expression.getClass())){
				inList = true;
				break;
			}
		}
		if(!inList)
			return false;
		for(Iterator<? extends Entity> iterator = expression.iterator(); iterator.hasNext();){
			Entity entity = iterator.next();
			if(entity instanceof Expression && !isAllowedEffect((Expression) entity, allowedList))
				return false;
		}
		return true;
	}
	
	@Override
	public void setDomain(Domain domain){
		super.setDomain(domain);
		for(Requirement requirement : Utilities.getRequirementsFor(domain, parser))
			parser.install(requirement);
	}
	
	@Override
	public void setProblem(Problem problem){
		super.setProblem(problem);
		for(Requirement requirement : Utilities.getRequirementsFor(problem.domain, parser))
			requirement.load(parser);
		for(Requirement requirement : Utilities.getRequirementsFor(problem, parser))
			requirement.load(parser);
	}
}
