package com.stephengware.java.planware.io.pddl.intp;

import com.stephengware.java.planware.IntentionalDomain;
import com.stephengware.java.planware.IntentionalOperator;
import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.io.Field;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Intention;
import com.stephengware.java.planware.logic.Term;
import com.stephengware.java.planware.ss.IntentionalStateSpace;

public class Templates {
	
	public static abstract class IntentionalDomainTemplate extends com.stephengware.java.planware.io.Templates.DomainTemplate {
		
		public static final Field<IntentionalDomain, IntentionalOperator[]> OPERATORS = new Field<>(IntentionalDomain.class, "operators", IntentionalOperator[].class);
	}
	
	public static abstract class IntentionalOperatorTemplate extends com.stephengware.java.planware.io.Templates.OperatorTemplate {
		
		public static final Field<IntentionalOperator, Term[]> AGENTS = new Field<>(IntentionalOperator.class, "agents", Term[].class);
	}
	
	public static abstract class IntentionalProblemTemplate extends com.stephengware.java.planware.io.Templates.ProblemTemplate {
	
		public static final Field<IntentionalProblem, IntentionalDomain> DOMAIN = new Field<>(IntentionalProblem.class, "domain", IntentionalDomain.class);
	}
	
	public static abstract class IntentionTemplate {
		
		public static final Field<Intention, Term> AGENT = new Field<>(Intention.class, "agent", Term.class);
		public static final Field<Intention, Expression> GOAL = new Field<>(Intention.class, "goal", Expression.class);
	}
	
	public static abstract class IntentionalStateSpaceTemplate extends com.stephengware.java.planware.io.Templates.StateSpaceTemplate {
		
		public static final Field<IntentionalStateSpace, IntentionalProblem> PROBLEM = new Field<>(IntentionalStateSpace.class, "problem", IntentionalProblem.class);
		public static final Field<IntentionalStateSpace, IntentionalStep[]> STEPS = new Field<>(IntentionalStateSpace.class, "steps", IntentionalStep[].class);
	}
}
