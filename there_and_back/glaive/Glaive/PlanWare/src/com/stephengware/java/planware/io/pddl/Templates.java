package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Field;
import com.stephengware.java.planware.logic.BooleanExpression;
import com.stephengware.java.planware.logic.Expression;

public class Templates {

	public static abstract class DomainTemplate extends com.stephengware.java.planware.io.Templates.DomainTemplate {
		
		public static final Field<Domain, Requirement[]> REQUIREMENTS = new Field<>(Domain.class, "requirements", Requirement[].class);
	}
	
	public static abstract class ProblemTemplate extends com.stephengware.java.planware.io.Templates.ProblemTemplate {
		
		public static final Field<Problem, Requirement[]> REQUIREMENTS = new Field<>(Problem.class, "requirements", Requirement[].class);
	}
	
	public static abstract class BooleanExpressionTemplate {
		
		public static final Field<BooleanExpression, Expression[]> ARGUMENTS = new Field<>(BooleanExpression.class, "arguments", Expression[].class);
	}
}
