package com.stephengware.java.planware.io.pddl;

import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.Root;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Variable;

public class Utilities {
	
	public static final Requirement[] parseRequirements(List document, Parser<SExpression> parser) throws ParseException {
		LinkedList<Requirement> requirements = new LinkedList<>();
		List requirementsList = document.findListStartingWith(PDDLManager.REQUIREMENTS_IDENTIFIER);
		if(requirementsList != null){
			for(Node node : requirementsList.rest()){
				Requirement requirement = parser.getDefinedObject(node.asSymbol().content.substring(1), Requirement.class);
				if(requirement == null)
					throw new ParseException(node, "The requirement \"" + node + "\" is not supported.");
				requirements.add(requirement);
			}
		}
		return requirements.toArray(new Requirement[requirements.size()]);
	}
	
	public static final Requirement[] getRequirementsFor(Domain domain, Parser<SExpression> parser){
		LinkedList<Requirement> requirements = new LinkedList<>();
		for(Extension<SExpression, ?> extension : parser.getInstalledExtensions()){
			if(extension instanceof Requirement){
				Requirement requirement = (Requirement) extension;
				if(requirement.isRequiredBy(domain))
					requirements.add(requirement);
			}
		}
		Collections.reverse(requirements);
		return removeImplications(requirements.toArray(new Requirement[requirements.size()]));
	}
	
	public static final Requirement[] getRequirementsFor(Domain domain, Builder<SExpression> builder){
		LinkedList<Requirement> requirements = new LinkedList<>();
		for(Extension<?, SExpression> extension : builder.getInstalledExtensions()){
			if(extension instanceof Requirement){
				Requirement requirement = (Requirement) extension;
				if(requirement.isRequiredBy(domain))
					requirements.add(requirement);
			}
		}
		Collections.reverse(requirements);
		return removeImplications(requirements.toArray(new Requirement[requirements.size()]));
	}
	
	public static final Requirement[] getRequirementsFor(Problem problem, Parser<SExpression> parser){
		LinkedList<Requirement> requirements = new LinkedList<>();
		for(Extension<SExpression, ?> extension : parser.getInstalledExtensions()){
			if(extension instanceof Requirement){
				Requirement requirement = (Requirement) extension;
				if(requirement.isRequiredBy(problem) && !requirement.isRequiredBy(problem.domain))
					requirements.add(requirement);
			}
		}
		Collections.reverse(requirements);
		return removeImplications(requirements.toArray(new Requirement[requirements.size()]));
	}
	
	public static final Requirement[] getRequirementsFor(Problem problem, Builder<SExpression> builder){
		LinkedList<Requirement> requirements = new LinkedList<>();
		for(Extension<?, SExpression> extension : builder.getInstalledExtensions()){
			if(extension instanceof Requirement){
				Requirement requirement = (Requirement) extension;
				if(requirement.isRequiredBy(problem) && !requirement.isRequiredBy(problem.domain))
					requirements.add(requirement);
			}
		}
		Collections.reverse(requirements);
		return removeImplications(requirements.toArray(new Requirement[requirements.size()]));
	}
	
	public static final SExpression buildRequirements(Requirement[] requirements) throws BuildException {
		List requirementsList = new List(PDDLManager.REQUIREMENTS_IDENTIFIER);
		for(Requirement requirement : removeImplications(requirements))
			requirementsList.addChild(":" + requirement.name);
		if(requirementsList.getLength() > 1)
			return requirementsList;
		else
			return new Root();
	}
	
	private static final Requirement[] removeImplications(Requirement[] requirements){
		LinkedList<Requirement> list = new LinkedList<>();
		for(Requirement requirement : requirements)
			list.add(requirement);
		for(Requirement requirement : requirements)
			for(Requirement prerequisite : requirement.getPrerequisites())
				list.remove(prerequisite);
		return list.toArray(new Requirement[list.size()]);
	}
	
	public static final Constant[] parseConstants(List constantsList, Parser<SExpression> parser) throws ParseException {
		LinkedList<Constant> constants = new LinkedList<>();
		HashSet<String> names = new HashSet<>();
		Universe universe = parser.getUniverse();
		if(universe != null){
			for(Constant object : universe.objects){
				constants.add(object);
				names.add(object.name);
			}
		}
		parser = parser.clone();
		parser.setUniverse(null);
		if(constantsList.isList(2, -1)){
			for(Node node : parser.parseOrFail(constantsList.getChild(1), Node[].class)){
				Constant constant = parser.parseOrFail(node, Constant.class);
				if(names.contains(constant.name))
					throw new ParseException("The constant \"" + constant + "\" is already defined.");
				constants.add(constant);
			}
		}
		return constants.toArray(new Constant[constants.size()]);
	}
	
	public static final Variable[] parseParameters(List parametersList, Parser<SExpression> parser) throws ParseException {
		LinkedList<Variable> parameters = new LinkedList<>();
		Parser<SExpression> parameterParser = parser.clone();
		parameterParser.setUniverse(null);
		if(parametersList != null && parametersList.isList(1, -1)){
			for(Node node : parameterParser.parseOrFail(parametersList.getChild(0), Node[].class)){
				Variable parameter = parameterParser.parseOrFail(node, Variable.class);
				if(parser.getDefinedObject(parameter.name, Variable.class) != null)
					throw new ParseException(node, "The " + parameter.getDescription() + " \"" + parameter + "\" cannot be redefined.");
				parser.defineObject(parameter.name, parameter);
				parameters.add(parameter);
			}
		}
		return parameters.toArray(new Variable[parameters.size()]);
	}
	
	public static final SExpression buildParameters(Variable[] parameters, Builder<SExpression> builder) throws BuildException {
		if(parameters.length == 0)
			return new Root();
		List parametersList = new List();
		Builder<SExpression> parameterBuilder = builder.clone();
		parameterBuilder.setUniverse(null);
		for(Variable parameter : parameters)
			parametersList.addChild(parameterBuilder.build(parameter));
		return parametersList;
	}
}
