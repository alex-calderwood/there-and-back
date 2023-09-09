package com.stephengware.java.planware;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;

import com.stephengware.java.planware.logic.Conjunction;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.Negation;
import com.stephengware.java.planware.util.CountableIterable;
import com.stephengware.java.planware.util.ImmutableSet;

public class AxiomTree {

	private final class Node {
		
		public final Literal literal;
		public final Literal negation;
		public final Axiom[] axioms;
		public final Node trueBranch;
		public final Node falseBranch;
		public final Node neitherBranch;
		
		public Node(Literal literal, Collection<Axiom> axioms, Node trueBranch, Node falseBranch, Node neitherBranch){
			this.literal = literal;
			if(literal == null)
				this.negation = null;
			else
				this.negation = literal.negate();
			this.axioms = axioms.toArray(new Axiom[axioms.size()]);
			this.trueBranch = trueBranch;
			this.falseBranch = falseBranch;
			this.neitherBranch = neitherBranch;
		}
	}
	
	private final class OpenWorldState extends State {

		private final HashSet<Literal> literals;
		
		private OpenWorldState(HashSet<Literal> literals){
			this.literals = literals;
		}
		
		public OpenWorldState(){
			this(new HashSet<Literal>());
		}
		
		@Override
		public Iterator<Literal> iterator(){
			return literals.iterator();
		}

		@Override
		protected boolean testLiteral(Literal literal){
			return literals.contains(literal);
		}

		@Override
		protected boolean imposeLiteral(Literal literal){
			return literals.add(literal);
		}

		@Override
		@SuppressWarnings("unchecked")
		public OpenWorldState clone(){
			return new OpenWorldState((HashSet<Literal>) literals.clone());
		}
	}
	
	private final Node root;
	
	public AxiomTree(ImmutableSet<Axiom> axioms){
		Collection<Axiom> sanitizedAxioms = sanitizeAxioms(axioms);
		root = makeNode(sanitizedAxioms, new OpenWorldState(), getPositiveLiterals(sanitizedAxioms));
	}
	
	private static final Collection<Axiom> sanitizeAxioms(ImmutableSet<Axiom> axioms){
		LinkedList<Axiom> sanitized = new LinkedList<Axiom>();
		for(Axiom axiom : axioms){
			CountableIterable<Clause> clauses = axiom.getPreconditionClauses();
			if(clauses.size() <= 1)
				sanitized.add(axiom);
			else
				for(Clause clause : axiom.getPreconditionClauses())
					sanitized.add(new Axiom(clause.expression, axiom.implies));
		}
		return sanitized;
	}
	
	private static final LinkedList<Literal> getPositiveLiterals(Collection<Axiom> axioms){
		HashSet<Literal> literals = new HashSet<>();
		for(Axiom axiom : axioms)
			axiom.collect(Literal.class, literals);
		HashSet<Literal> positiveLiterals = new HashSet<>();
		for(Literal literal : literals)
			if(literal instanceof Negation)
				positiveLiterals.add(literal.negate());
			else
				positiveLiterals.add(literal);
		LinkedList<Literal> result = new LinkedList<>();
		result.addAll(positiveLiterals);
		return result;
	}
	
	@SuppressWarnings("unchecked")
	private final Node makeNode(Collection<Axiom> axioms, OpenWorldState state, LinkedList<Literal> literals){
		LinkedList<Axiom> satisfied = new LinkedList<>();
		for(Axiom axiom : axioms)
			if(state.isTrue(axiom.context))
				satisfied.add(axiom);
		Division bestDivision = null;
		for(Literal literal : literals){
			Division division = divide(axioms, state, literal);
			if(division.isBetterThan(bestDivision))
				bestDivision = division;
		}
		if(bestDivision == null || bestDivision.trueSet.size() + bestDivision.falseSet.size() == 0){
			if(satisfied.size() == 0)
				return null;
			else
				return new Node(null, satisfied, null, null, null);
		}
		LinkedList<Literal> remainingLiterals = (LinkedList<Literal>) literals.clone();
		remainingLiterals.remove(bestDivision.literal);
		OpenWorldState trueState = state.clone();
		trueState.impose(bestDivision.literal);
		Node trueBranch = makeNode(bestDivision.trueSet, trueState, remainingLiterals);
		OpenWorldState falseState = state.clone();
		falseState.impose(bestDivision.literal.negate());
		Node falseBranch = makeNode(bestDivision.falseSet, falseState, remainingLiterals);
		Node neitherBranch = makeNode(bestDivision.neitherSet, state, remainingLiterals);
		return new Node(bestDivision.literal, satisfied, trueBranch, falseBranch, neitherBranch);
	}
	
	private static final class Division {
		
		public final Literal literal;
		public final LinkedList<Axiom> trueSet = new LinkedList<>();
		public final LinkedList<Axiom> falseSet = new LinkedList<>();
		public final LinkedList<Axiom> neitherSet = new LinkedList<>();
				
		public Division(Literal literal){
			this.literal = literal;
		}
		
		public boolean isBetterThan(Division other){
			if(other == null)
				return true;
			if(Math.min(trueSet.size(), falseSet.size()) > Math.min(other.trueSet.size(), other.falseSet.size()))
				return true;
			else if(neitherSet.size() < other.neitherSet.size())
				return true;
			else
				return false;
		}
		
		public String toString(){
			return "[Divide on " + literal + ": " + trueSet.size() + " true, " + falseSet.size() + " false, " + neitherSet.size() + " neither]";
		}
	}
	
	private static final Division divide(Collection<Axiom> axioms, OpenWorldState state, Literal literal){
		Literal negation = literal.negate();
		Division division = new Division(literal);
		for(Axiom axiom : axioms){
			if(state.isTrue(axiom.context))
				continue;
			else if(contains(axiom.context, literal))
				division.trueSet.add(axiom);
			else if(contains(axiom.context, negation))
				division.falseSet.add(axiom);
			else
				division.neitherSet.add(axiom);
		}
		return division;
	}
	
	private static final boolean contains(Expression expression, Literal literal){
		if(expression instanceof Literal)
			return expression.equals(literal);
		else
			for(Expression argument : ((Conjunction) expression).arguments)
				if(((Literal) argument).equals(literal))
					return true;
		return false;
	}
	
	public Iterator<Axiom> getApplicableAxioms(State state){
		LinkedList<Axiom> axioms = new LinkedList<>();
		collectAxioms(root, axioms, state);
		return axioms.iterator();
	}
	
	private final void collectAxioms(Node node, LinkedList<Axiom> axioms, State state){
		if(node == null)
			return;
		for(Axiom satisfied : node.axioms)
			axioms.add(satisfied);
		if(node.literal != null){
			if(state.isTrue(node.literal))
				collectAxioms(node.trueBranch, axioms, state);
			else if(state.isTrue(node.negation))
				collectAxioms(node.falseBranch, axioms, state);
		}
		collectAxioms(node.neitherBranch, axioms, state);
	}
	
	@Override
	public String toString(){
		return "[Axiom Tree]";
	}
}
