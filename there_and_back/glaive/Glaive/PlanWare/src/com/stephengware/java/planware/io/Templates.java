package com.stephengware.java.planware.io;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Plan;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.logic.ConditionalExpression;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Equality;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.ExpressionEquality;
import com.stephengware.java.planware.logic.ExpressionVariable;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.ModalExpression;
import com.stephengware.java.planware.logic.NegatedLiteral;
import com.stephengware.java.planware.logic.Negation;
import com.stephengware.java.planware.logic.Predication;
import com.stephengware.java.planware.logic.QuantifiedExpression;
import com.stephengware.java.planware.logic.Taxonomy;
import com.stephengware.java.planware.logic.Term;
import com.stephengware.java.planware.logic.TermEquality;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.Type;
import com.stephengware.java.planware.logic.Variable;
import com.stephengware.java.planware.ss.StateSpace;

public class Templates {

	public static abstract class DomainTemplate {
		
		public static final Field<Domain, String> NAME = new Field<>(Domain.class, "name", String.class);
		public static final Field<Domain, Universe> UNIVERSE = new Field<>(Domain.class, "universe", Universe.class);
		public static final Field<Domain, Operator[]> OPERATORS = new Field<>(Domain.class, "operators", Operator[].class);
		public static final Field<Domain, com.stephengware.java.planware.AxiomTemplate[]> AXIOMS = new Field<>(Domain.class, "axioms", com.stephengware.java.planware.AxiomTemplate[].class);
	}
	
	public static abstract class OperatorTemplate {
		
		public static final Field<Operator, String> NAME = new Field<>(Operator.class, "name", String.class);
		public static final Field<Operator, Variable[]> PARAMETERS = new Field<>(Operator.class, "parameters", Variable[].class);
		public static final Field<Operator, Expression> PRECONDITION = new Field<>(Operator.class, "precondition", Expression.class);
		public static final Field<Operator, Expression> EFFECT = new Field<>(Operator.class, "effect", Expression.class);
	}
	
	public static abstract class AxiomTemplateTemplate {
		
		public static final Field<AxiomTemplate, Variable[]> PARAMETERS = new Field<>(AxiomTemplate.class, "parameters", Variable[].class);
		public static final Field<AxiomTemplate, Expression> CONTEXT = new Field<>(AxiomTemplate.class, "context", Expression.class);
		public static final Field<AxiomTemplate, Expression> IMPLIES = new Field<>(AxiomTemplate.class, "implies", Expression.class);
	}
	
	public static abstract class ProblemTemplate {
		
		public static final Field<Problem, String> NAME = new Field<>(Problem.class, "name", String.class);
		public static final Field<Problem, Domain> DOMAIN = new Field<>(Problem.class, "domain", Domain.class);
		public static final Field<Problem, Universe> UNIVERSE = new Field<>(Problem.class, "universe", Universe.class);
		public static final Field<Problem, Expression> INITIAL_STATE = new Field<>(Problem.class, "initial state", Expression.class);
		public static final Field<Problem, Expression> GOAL = new Field<>(Problem.class, "goal", Expression.class);
	}
	
	public static abstract class UniverseTemplate {
		
		public static final Field<Universe, Taxonomy> TAXONOMY = new Field<>(Universe.class, "taxonomy", Taxonomy.class);
		public static final Field<Universe, Constant[]> OBJECTS = new Field<>(Universe.class, "objects", Constant[].class);
		public static final Field<Universe, Predication[]> PREDICATES = new Field<>(Universe.class, "predicates", Predication[].class);
		public static final Field<Universe, ModalExpression[]> MODALITIES = new Field<>(Universe.class, "modalities", ModalExpression[].class);
	}

	public static abstract class PlanTemplate {
		
		public static final Field<Plan, String> NAME = new Field<>(Plan.class, "name", String.class);
		public static final Field<Plan, Problem> PROBLEM = new Field<>(Plan.class, "problem", Problem.class);
		public static final Field<Plan, Step[]> STEPS = new Field<>(Plan.class, "steps", Step[].class);
	}
	
	public static abstract class StepTemplate {
		
		public static final Field<Step, Operator> OPERATOR = new Field<>(Step.class, "operator", Operator.class);
		public static final Field<Step, Entity[]> ARGUMENTS = new Field<>(Step.class, "arguments", Entity[].class);
		public static final Field<Step, Expression> PRECONDITION = new Field<>(Step.class, "precondition", Expression.class);
		public static final Field<Step, Expression> EFFECT = new Field<>(Step.class, "effect", Expression.class);
	}
	
	public static abstract class AxiomTemplate {
		
		public static final Field<Axiom, Expression> CONTEXT = new Field<>(Axiom.class, "context", Expression.class);
		public static final Field<Axiom, Expression> IMPLIES = new Field<>(Axiom.class, "implies", Expression.class);
	}
	
	public static abstract class StateSpaceTemplate {
		
		public static final Field<StateSpace, Problem> PROBLEM = new Field<>(StateSpace.class, "problem", Problem.class);
		public static final Field<StateSpace, Literal[]> LITERALS = new Field<>(StateSpace.class, "literals", Literal[].class);
		public static final Field<StateSpace, Step[]> STEPS = new Field<>(StateSpace.class, "steps", Step[].class);
		public static final Field<StateSpace, Axiom[]> AXIOMS = new Field<>(StateSpace.class, "axioms", Axiom[].class);
	}
	
	public static abstract class TypeTemplate {
		
		public static final Field<Type, String> NAME = new Field<>(Type.class, "name", String.class);
	}
	
	public static abstract class TermTemplate {
		
		public static final Field<Term, String> NAME = new Field<>(Term.class, "name", String.class);
		public static final Field<Term, Type> TYPE = new Field<>(Term.class, "type", Type.class);
	}
	
	public static abstract class VariableTemplate {
		
		public static final Field<Variable, String> NAME = new Field<>(Variable.class, "name", String.class);
	}
	
	public static abstract class ExpressionVariableTemplate {
		
		public static final Field<ExpressionVariable, Boolean> IMPOSABLE = new Field<>(ExpressionVariable.class, "imposable", Boolean.class);
	}
	
	public static abstract class PredicationTemplate {
		
		public static final Field<Predication, String> PREDICATE = new Field<>(Predication.class, "predicate", String.class);
		public static final Field<Predication, Term[]> TERMS = new Field<>(Predication.class, "terms", Term[].class);
	}
	
	public static abstract class NegationTemplate {
		
		public static final Field<Negation, Expression> ARGUMENT = new Field<>(Negation.class, "argument", Expression.class);
	}
	
	public static abstract class NegatedLiteralTemplate {
		
		public static final Field<NegatedLiteral, Literal> ARGUMENT = new Field<>(NegatedLiteral.class, "argument", Literal.class);
	}
	
	public static abstract class ConditionalExpressionTemplate {
		
		public static final Field<ConditionalExpression, Expression> CONDITION = new Field<>(ConditionalExpression.class, "condition", Expression.class);
		public static final Field<ConditionalExpression, Expression> EFFECT = new Field<>(ConditionalExpression.class, "effect", Expression.class);
	}
	
	public static abstract class EqualityTemplate {
		
		public static final Field<Equality, Entity> LEFT = new Field<>(Equality.class, "left", Entity.class);
		public static final Field<Equality, Entity> RIGHT = new Field<>(Equality.class, "right", Entity.class);
	}
	
	public static abstract class TermEqualityTemplate {
		
		public static final Field<TermEquality, Term> LEFT = new Field<>(TermEquality.class, "left", Term.class);
		public static final Field<TermEquality, Term> RIGHT = new Field<>(TermEquality.class, "right", Term.class);
	}
	
	public static abstract class ExpressionEqualityTemplate {
		
		public static final Field<ExpressionEquality, Expression> LEFT = new Field<>(ExpressionEquality.class, "left", Expression.class);
		public static final Field<ExpressionEquality, Expression> RIGHT = new Field<>(ExpressionEquality.class, "right", Expression.class);
	}
	
	public static abstract class QuantifiedExpressionTemplate {
		
		public static final Field<QuantifiedExpression, TermVariable> VARIABLE = new Field<>(QuantifiedExpression.class, "variable", TermVariable.class);
		public static final Field<QuantifiedExpression, Expression> ARGUMENT = new Field<>(QuantifiedExpression.class, "argument", Expression.class);
	}
	
	public static abstract class ModalExpressionTemplate {
		
		public static final Field<ModalExpression, Entity[]> ARGUMENTS = new Field<>(ModalExpression.class, "arguments", Entity[].class);
	}
}
