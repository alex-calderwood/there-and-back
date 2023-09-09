package com.stephengware.java.planware.io.pddl;

import java.util.LinkedList;

import com.stephengware.java.planware.ListPlan;
import com.stephengware.java.planware.Plan;
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

public class PlanExtension extends SimpleExtension<SExpression, Plan> {

	public static final String PLAN_IDENTIFIER = "plan";
	public static final String PROBLEM_IDENTIFIER = ":problem";
	public static final String STEPS_IDENTIFIER = ":steps";
	
	public PlanExtension(){
		super(Plan.class, true);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		String name = parseName(document.asList(), parser);
		Problem problem = parseProblem(document.asList(), parser);
		Step[] steps = parseSteps(document.asList(), parser);
		ListPlan plan = new ListPlan(name, problem);
		for(Step step : steps)
			plan.addStep(step);
		succeed(plan);
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(2, -1) &&
				document.asList().getChild(0).isSymbol(PDDLManager.DEFINITION_KEYWORD) &&
				document.asList().getChild(1).isList(1, -1) &&
				document.asList().getChild(1).asList().getChild(0).isSymbol(PLAN_IDENTIFIER);
	}
	
	protected String parseName(List document, Parser<SExpression> parser) throws ParseException {
		String name = document.getChild(1).asList(2).getChild(1).asSymbol().content;
		parser.define(Templates.PlanTemplate.NAME, name);
		return name;
	}
	
	protected Problem parseProblem(List document, Parser<SExpression> parser) throws ParseException {
		List problemList = document.requireListStartingWith(PROBLEM_IDENTIFIER);
		String name = problemList.asList(2).getChild(1).asSymbol().content;
		Problem problem = parser.requireDefinedObject(name, Problem.class);
		parser.setProblem(problem);
		parser.define(Templates.PlanTemplate.PROBLEM, problem);
		return problem;
	}
	
	protected Step[] parseSteps(List document, Parser<SExpression> parser) throws ParseException {
		LinkedList<Step> steps = new LinkedList<>();
		List stepsList = document.findListStartingWith(STEPS_IDENTIFIER);
		if(stepsList != null && stepsList.isList(2, -1))
			for(Node node : parser.parseOrFail(stepsList.getChild(1), Node[].class))
				steps.add(parser.parseOrFail(node, Step.class));
		Step[] stespArray = steps.toArray(new Step[steps.size()]);
		parser.define(Templates.PlanTemplate.STEPS, stespArray);
		return stespArray;
	}
	
	@Override
	public SExpression build(Plan plan, SExpression document, Builder<SExpression> builder) throws BuildException {
		List planList = new List(PDDLManager.DEFINITION_KEYWORD);
		planList.setFormatRule(FormatRule.PDDL_DOCUMENT);
		buildName(plan, planList, builder);
		buildProblem(plan, planList, builder);
		buildSteps(plan, planList, builder);
		return planList;
	}
	
	protected void buildName(Plan plan, List document, Builder<SExpression> builder) throws BuildException {
		document.addChild(new List(PLAN_IDENTIFIER, plan.name));
	}
	
	protected void buildProblem(Plan plan, List document, Builder<SExpression> builder) throws BuildException {
		document.addChild(new List(PROBLEM_IDENTIFIER, plan.problem.name));
	}

	protected void buildSteps(Plan plan, List document, Builder<SExpression> builder) throws BuildException {
		if(plan.countSteps() == 0)
			return;
		List stepsList = new List(STEPS_IDENTIFIER);
		stepsList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(Step step : plan.steps())
			stepsList.addChild(builder.build(step));
		document.addChild(stepsList);
	}
}
