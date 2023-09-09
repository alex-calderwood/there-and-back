package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Entity;

public class StepExtension extends SimpleExtension<SExpression, Step> {

	public StepExtension(){
		super(Step.class, true);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		Operator operator = parseOperator(document.asList(), parser);
		Entity[] arguments = parseArguments(document.asList(), parser);
		Step step = null;
		try{
			step = parser.requireProblem().makeStep(operator.name, arguments);
		}
		catch(IllegalArgumentException ex){
			throw new ParseException(document, ex.getMessage());
		}
		parser.define(Templates.StepTemplate.PRECONDITION, step.precondition);
		parser.define(Templates.StepTemplate.EFFECT, step.effect);
		succeed(step);
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) &&
				document.asList().getChild(0).isSymbol();
	}
	
	protected Operator parseOperator(List document, Parser<SExpression> parser) throws ParseException {
		String name = document.getChild(0).asSymbol().content;
		Operator operator = null;
		try{
			operator = parser.requireDomain().getOperator(name);
		}
		catch(IllegalArgumentException ex){
			throw new ParseException(document, ex.getMessage());
		}
		parser.define(Templates.StepTemplate.OPERATOR, operator);
		return operator;
	}
	
	protected Entity[] parseArguments(List document, Parser<SExpression> parser) throws ParseException {
		Entity[] arguments;
		if(document.isList(1))
			arguments = new Entity[0];
		else{
			Node[] nodes = parser.parseOrFail(document.getChild(1), Node[].class);
			arguments = new Entity[nodes.length];
			for(int i=0; i<arguments.length; i++)
				arguments[i] = parser.parseOrFail(nodes[i], Entity.class);
		}
		parser.define(Templates.StepTemplate.ARGUMENTS, arguments);
		return arguments;
	}
	
	@Override
	public SExpression build(Step step, SExpression document, Builder<SExpression> builder) throws BuildException {
		List stepList = new List(step.name);
		for(Entity argument : step.arguments)
			stepList.addChild(builder.build(argument));
		return stepList;
	}
}
