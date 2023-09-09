package com.stephengware.java.planware.io.pddl;

import java.util.LinkedHashSet;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.ss.StateSpace;
import com.stephengware.java.planware.util.ImmutableSet;

public class StateSpaceExtension extends SimpleExtension<SExpression, StateSpace> {

	public static final String SPACE_IDENTIFIER = "space";
	public static final String LITERALS_IDENTIFIER = ":literals";
	public static final String STEPS_IDENTIFIER = ":steps";
	public static final String AXIOMS_IDENTIFIER = ":axioms";
	
	public StateSpaceExtension(){
		super(StateSpace.class, true);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		Problem problem = parseProblem(document.asList(), parser);
		ImmutableSet<Literal> literals = parseLiterals(document.asList(), parser);
		ImmutableSet<Step> steps = parseSteps(document.asList(), parser);
		ImmutableSet<Axiom> axioms = parseAxioms(document.asList(), parser);
		succeed(new StateSpace(problem, literals, steps, axioms));
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(2, -1) &&
				document.asList().getChild(0).isSymbol(PDDLManager.DEFINITION_KEYWORD) &&
				document.asList().getChild(1).isList(2) &&
				document.asList().getChild(1).asList().getChild(0).isSymbol(SPACE_IDENTIFIER);
	}
	
	protected Problem parseProblem(List document, Parser<SExpression> parser) throws ParseException {
		String name = document.requireListStartingWith(SPACE_IDENTIFIER).asList(2).getChild(1).asSymbol().content;
		Problem problem = parser.requireDefinedObject(name, Problem.class);
		parser.setProblem(problem);
		for(Requirement requirement : Utilities.getRequirementsFor(problem.domain, parser))
			requirement.load(parser);
		for(Requirement requirement : Utilities.getRequirementsFor(problem, parser))
			requirement.load(parser);
		parser.define(Templates.StateSpaceTemplate.PROBLEM, problem);
		return problem;
	}
	
	protected ImmutableSet<Literal> parseLiterals(List document, Parser<SExpression> parser) throws ParseException {
		List literalsList = document.findListStartingWith(LITERALS_IDENTIFIER);
		LinkedHashSet<Literal> literals = new LinkedHashSet<>();
		for(Node node : literalsList.rest())
			literals.add(parser.parseOrFail(node, Literal.class));
		parser.define(Templates.StateSpaceTemplate.LITERALS, literals.toArray(new Literal[literals.size()]));
		return new ImmutableSet<>(literals, Literal.class);
	}
	
	protected ImmutableSet<Step> parseSteps(List document, Parser<SExpression> parser) throws ParseException {
		List stepsList = document.findListStartingWith(STEPS_IDENTIFIER);
		LinkedHashSet<Step> steps = new LinkedHashSet<>();
		for(Node node : stepsList.rest())
			steps.add(parser.parseOrFail(node, Step.class));
		parser.define(Templates.StateSpaceTemplate.STEPS, steps.toArray(new Step[steps.size()]));
		return new ImmutableSet<>(steps, Step.class);
	}
	
	protected ImmutableSet<Axiom> parseAxioms(List document, Parser<SExpression> parser) throws ParseException {
		List axiomsList = document.findListStartingWith(AXIOMS_IDENTIFIER);
		LinkedHashSet<Axiom> axioms = new LinkedHashSet<>();
		for(Node node : axiomsList.rest())
			axioms.add(parser.parseOrFail(node, Axiom.class));
		parser.define(Templates.StateSpaceTemplate.AXIOMS, axioms.toArray(new Axiom[axioms.size()]));
		return new ImmutableSet<>(axioms, Axiom.class);
	}
	
	@Override
	public SExpression build(StateSpace space, SExpression document, Builder<SExpression> builder) throws BuildException {
		builder.setProblem(space.problem);
		for(Requirement requirement : Utilities.getRequirementsFor(space.problem.domain, builder))
			requirement.load(builder);
		for(Requirement requirement : Utilities.getRequirementsFor(space.problem, builder))
			requirement.load(builder);
		List spaceList = new List(PDDLManager.DEFINITION_KEYWORD);
		spaceList.setFormatRule(FormatRule.PDDL_DOCUMENT);
		buildName(space, spaceList, builder);
		buildLiterals(space, spaceList, builder);
		buildSteps(space, spaceList, builder);
		buildAxioms(space, spaceList, builder);
		return spaceList;
	}
	
	protected void buildName(StateSpace space, List document, Builder<SExpression> builder) throws BuildException {
		document.addChild(new List(SPACE_IDENTIFIER, space.problem.name));
	}
	
	protected void buildLiterals(StateSpace space, List document, Builder<SExpression> builder) throws BuildException {
		List literalsList = new List(LITERALS_IDENTIFIER);
		literalsList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(Literal literal : space.literals)
			literalsList.addChild(builder.build(literal));
		document.addChild(literalsList);
	}
	
	protected void buildSteps(StateSpace space, List document, Builder<SExpression> builder) throws BuildException {
		List stepsList = new List(STEPS_IDENTIFIER);
		stepsList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(Step step : space.steps)
			stepsList.addChild(builder.build(step));
		document.addChild(stepsList);
	}
	
	protected void buildAxioms(StateSpace space, List document, Builder<SExpression> builder) throws BuildException {
		List axiomsList = new List(AXIOMS_IDENTIFIER);
		axiomsList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(Axiom axiom : space.axioms)
			axiomsList.addChild(builder.build(axiom));
		document.addChild(axiomsList);
	}
}
