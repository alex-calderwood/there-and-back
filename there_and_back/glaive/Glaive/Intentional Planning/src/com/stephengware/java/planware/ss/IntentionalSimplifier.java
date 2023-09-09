package com.stephengware.java.planware.ss;

import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.Queue;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.graph.AxiomNode;
import com.stephengware.java.planware.graph.ChangeNode;
import com.stephengware.java.planware.graph.EffectNode;
import com.stephengware.java.planware.graph.Node;
import com.stephengware.java.planware.ig.GoalNode;
import com.stephengware.java.planware.ig.IntentionGraph;
import com.stephengware.java.planware.ig.StepNode;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Intention;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.pg.LiteralNode;
import com.stephengware.java.planware.util.ImmutableSet;

public class IntentionalSimplifier {

	public static IntentionalStateSpace removeUnusedElements(IntentionalStateSpace space){
		MonotonicallyIncreasingState state = Simplifier.expandFromInitialState(space);
		return new IntentionalStateSpace(space.problem, Simplifier.removeUnusedLiterals(space, state), removeUnusedSteps(space, state), Simplifier.removeUnusedAxioms(space, state));
	}
	
	public static IntentionalStateSpace removeUnusedLiterals(IntentionalStateSpace space, Problem problem){
		return new IntentionalStateSpace(space.problem, Simplifier.removeUnusedLiterals(space, Simplifier.expandFromInitialState(space)), space.steps, space.axioms);
	}
	
	public static IntentionalStateSpace removeUnusedSteps(IntentionalStateSpace space, Problem problem){
		return new IntentionalStateSpace(space.problem, space.literals, removeUnusedSteps(space, Simplifier.expandFromInitialState(space)), space.axioms);
	}
	
	public static IntentionalStateSpace removeUnusedAxioms(IntentionalStateSpace space, Problem problem){
		return new IntentionalStateSpace(space.problem, space.literals, space.steps, Simplifier.removeUnusedAxioms(space, Simplifier.expandFromInitialState(space)));
	}
	
	@SuppressWarnings("unchecked")
	protected static ImmutableSet<IntentionalStep> removeUnusedSteps(IntentionalStateSpace space, MonotonicallyIncreasingState state){
		return (ImmutableSet<IntentionalStep>) (ImmutableSet<?>) Simplifier.removeUnusedSteps(space, state);
	}
	
	private static final class Space {
		
		public final IntentionalProblem problem;
		private final HashSet<Node> nodes = new HashSet<>();
		public final HashSet<Literal> literals = new HashSet<>();
		public final HashSet<IntentionalStep> steps = new HashSet<>();
		public final HashSet<Axiom> axioms = new HashSet<>();
		
		public Space(IntentionalProblem problem){
			this.problem = problem;
		}
		
		public boolean add(Node node){
			if(nodes.add(node)){
				if(node instanceof LiteralNode)
					literals.add(((LiteralNode) node).literal);
				else if(node instanceof StepNode)
					steps.add(((StepNode) node).step);
				else if(node instanceof AxiomNode)
					axioms.add(((AxiomNode) node).axiom);
				if(node instanceof ChangeNode)
					for(EffectNode effectNode : ((ChangeNode) node).children)
						add(effectNode.child);
				return true;
			}
			else
				return false;
		}
		
		public final IntentionalStateSpace getStateSpace(IntentionalStateSpace space){
			LinkedHashSet<Literal> newLiterals = new LinkedHashSet<>();
			for(Literal literal : space.literals)
				if(literals.contains(literal))
					newLiterals.add(literal);
			LinkedHashSet<IntentionalStep> newSteps = new LinkedHashSet<>();
			for(IntentionalStep step : space.steps)
				if(steps.contains(step))
					newSteps.add(step);
			LinkedHashSet<Axiom> newAxioms = new LinkedHashSet<>();
			for(Axiom axiom : space.axioms)
				if(axioms.contains(axiom))
					newAxioms.add(axiom);
			return new IntentionalStateSpace(problem, newLiterals, newSteps, newAxioms);
		}
	}
	
	public static IntentionalStateSpace removeUnmotivatedElements(IntentionalStateSpace space){
		IntentionGraph graph = new IntentionGraph(space);
		IntentionalStateSpace pruned = pruneUnmotivatedElements(space, graph);
		while(space.literals.length > pruned.literals.length || space.steps.length > pruned.steps.length || space.axioms.length > pruned.axioms.length){
			space = pruned;
			pruned = pruneUnmotivatedElements(space, graph);
		}
		return pruned;
	}
	
	public static IntentionalStateSpace pruneUnmotivatedElements(IntentionalStateSpace space, IntentionGraph graph){
		Space motivated = new Space(space.problem);
		for(Literal literal : space.problem.getInitialState().collect(Literal.class))
			motivated.literals.add(literal);
		for(IntentionalStep step : space.steps)
			if(step.agents.length == 0)
				motivated.steps.add(step);
		for(Intention intention : space.collect(Intention.class)){
			Constant agent = (Constant) intention.agent;
			GoalNode goal = graph.getGoalNode(intention.goal);
			HashSet<Node> visited = new HashSet<>();
			Queue<Node> queue = new LinkedList<>();
			queue.add(goal);
			while(!queue.isEmpty()){
				Node node = queue.poll();
				boolean candidate = true;
				if(node instanceof StepNode)
					candidate = ((StepNode) node).step.agents.contains(agent);
				if(candidate && !visited.contains(node)){
					visited.add(node);
					motivated.add(node);
					for(Iterator<? extends Node> parents = node.parents(); parents.hasNext();)
						queue.add(parents.next());
				}
			}
		}
		return motivated.getStateSpace(space);
	}
}
