package com.stephengware.java.planware.io.pddl;

import java.util.LinkedList;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.Parent;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Conjunction;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.util.ImmutableSet;

public class ProblemExtension extends SimpleExtension<SExpression, Problem> {

	public static final String PROBLEM_IDENTIFIER = "problem";
	public static final String DOMAIN_IDENTIFIER = ":domain";
	public static final String OBJECTS_IDENTIFIER = ":objects";
	public static final String INITIAL_STATE_IDENTIFIER = ":init";
	public static final String GOAL_IDENTIFIER = ":goal";
	
	public ProblemExtension(){
		super(Problem.class, true);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		String name = parseName(document.asList(), parser);
		Domain domain = parseDomain(document.asList(), parser);
		parseRequirements(document.asList(), parser);
		Universe universe = parseUniverse(document.asList(), parser);
		Expression initialState = parseInitialState(document.asList(), parser);
		Expression goal = parseGoal(document.asList(), parser);
		succeed(new Problem(name, domain, universe, initialState, goal));
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(2, -1) &&
				document.asList().getChild(0).isSymbol(PDDLManager.DEFINITION_KEYWORD) &&
				document.asList().getChild(1).isList(2) &&
				document.asList().getChild(1).asList().getChild(0).isSymbol(PROBLEM_IDENTIFIER);
	}
	
	protected String parseName(List document, Parser<SExpression> parser) throws ParseException {
		String name = document.asList().getChild(1).asList().getChild(1).asSymbol().content;
		parser.define(Templates.ProblemTemplate.NAME, name);
		return name;
	}
	
	protected Domain parseDomain(List document, Parser<SExpression> parser) throws ParseException {
		String name = document.requireListStartingWith(DOMAIN_IDENTIFIER).asList(2).getChild(1).asSymbol().content;
		Domain domain = parser.requireDefinedObject(name, Domain.class);
		parser.setDomain(domain);
		parser.define(Templates.ProblemTemplate.DOMAIN, domain);
		return domain;
	}
	
	protected Requirement[] parseRequirements(List document, Parser<SExpression> parser) throws ParseException {
		Domain domain = parser.requireDomain();
		for(Requirement requirement : Utilities.getRequirementsFor(domain, parser))
			requirement.load(parser);
		Requirement[] requirements = Utilities.parseRequirements(document, parser);
		for(Requirement requirement : requirements)
			requirement.load(parser);
		parser.define(Templates.ProblemTemplate.REQUIREMENTS, requirements);
		return requirements;
	}
	
	protected Universe parseUniverse(List document, Parser<SExpression> parser) throws ParseException {
		Universe universe = parser.requireUniverse();
		List constantsList = document.findListStartingWith(OBJECTS_IDENTIFIER);
		Constant[] objects;
		if(constantsList != null)
			objects = Utilities.parseConstants(constantsList, parser);
		else
			objects = parser.requireUniverse().objects.toArray();
		universe = new Universe(universe.taxonomy, new ImmutableSet<Constant>(objects), universe.predicates, universe.modalities);
		parser.setUniverse(universe);
		parser.define(Templates.ProblemTemplate.UNIVERSE, universe);
		return universe;
	}
	
	protected Expression parseInitialState(List document, Parser<SExpression> parser) throws ParseException {
		List initList = document.findListStartingWith(INITIAL_STATE_IDENTIFIER);
		Expression initialState;
		if(initList == null)
			initialState = Expression.TRUE;
		else{
			LinkedList<Expression> initExpressions = new LinkedList<>();
			for(Node node : initList.rest())
				initExpressions.add(PDDLManager.parseEffect(node, parser));
			if(initExpressions.size() == 0)
				initialState = Expression.TRUE;
			else if(initExpressions.size() == 1)
				initialState = initExpressions.get(0);
			else
				initialState = new Conjunction(initExpressions);
		}
		parser.define(Templates.ProblemTemplate.INITIAL_STATE, initialState);
		return initialState;
	}
	
	protected Expression parseGoal(List document, Parser<SExpression> parser) throws ParseException {
		List goalList = document.findListStartingWith(GOAL_IDENTIFIER);
		Expression goal;
		if(goalList == null)
			goal = Expression.TRUE;
		else
			goal = PDDLManager.parseGoal(goalList.asList(2).getChild(1), parser);
		parser.define(Templates.ProblemTemplate.GOAL, goal);
		return goal;
	}
	
	@Override
	public SExpression build(Problem problem, SExpression document, Builder<SExpression> builder) throws BuildException {
		List problemList = new List(PDDLManager.DEFINITION_KEYWORD);
		problemList.setFormatRule(FormatRule.PDDL_DOCUMENT);
		buildName(problem, problemList, builder);
		buildDomain(problem, problemList, builder);
		buildRequirements(problem, problemList, builder);
		buildUniverse(problem, problemList, builder);
		buildInitialState(problem, problemList, builder);
		buildGoal(problem, problemList, builder);
		return problemList;
	}
	
	protected void buildName(Problem problem, List document, Builder<SExpression> builder) throws BuildException {
		document.addChild(new List(PROBLEM_IDENTIFIER, problem.name));
	}

	protected void buildDomain(Problem problem, List document, Builder<SExpression> builder) throws BuildException {
		document.addChild(new List(DOMAIN_IDENTIFIER, problem.domain.name));
		builder.setDomain(problem.domain);
	}
	
	protected void buildRequirements(Problem problem, List document, Builder<SExpression> builder) throws BuildException {
		Requirement[] requirements = Utilities.getRequirementsFor(problem.domain, builder);
		for(Requirement requirement : requirements)
			requirement.load(builder);
		requirements = Utilities.getRequirementsFor(problem, builder);
		document.addChild(Utilities.buildRequirements(requirements));
	}

	protected void buildUniverse(Problem problem, List document, Builder<SExpression> builder) throws BuildException {
		LinkedList<Constant> objects = new LinkedList<>();
		for(Constant object : problem.universe.objects)
			objects.add(object);
		for(Constant object : problem.domain.universe.objects)
			objects.remove(object);
		ImmutableSet<Constant> problemObjects = new ImmutableSet<>(objects.toArray(new Constant[objects.size()]));
		Universe problemUniverse = new Universe(problem.universe.taxonomy, problemObjects, problem.universe.predicates, problem.universe.modalities);
		Parent universeDocument = (Parent) builder.build(problemUniverse);
		List constantsList = universeDocument.findListStartingWith(UniverseExtension.CONSTANTS_IDENTIFIER);
		if(constantsList == null)
			return;
		constantsList.replaceChild(0, OBJECTS_IDENTIFIER);
		document.addChild(constantsList);
	}
	
	protected void buildInitialState(Problem problem, List document, Builder<SExpression> builder) throws BuildException {
		if(problem.initialState == Expression.TRUE)
			return;
		List initList = new List(INITIAL_STATE_IDENTIFIER);
		initList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		Expression initialState = problem.initialState.toDNF();
		if(initialState instanceof Literal)
			initList.addChild(builder.build(problem.initialState));
		else if(initialState instanceof Conjunction)
			for(Expression argument : ((Conjunction) initialState).arguments)
				initList.addChild(builder.build(argument));
		document.addChild(initList);
	}
	
	protected void buildGoal(Problem problem, List document, Builder<SExpression> builder) throws BuildException {
		if(problem.goal == Expression.TRUE)
			return;
		document.addChild(new List(GOAL_IDENTIFIER, builder.build(problem.goal)));
	}
}
