package com.stephengware.java.glaive;


import java.util.Comparator;

import com.stephengware.java.planware.Argument;
import com.stephengware.java.planware.ArgumentMap;
import com.stephengware.java.planware.AxiomTree;
import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.Search;
import com.stephengware.java.planware.ig.IntentionGraph;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.search.BestFirst;
import com.stephengware.java.planware.search.Heuristic;
import com.stephengware.java.planware.search.HeuristicSearch;
import com.stephengware.java.planware.ss.IntentionalStateSpace;
import com.stephengware.java.planware.ss.IntentionalStateSpacePlanner;

public class Glaive extends IntentionalStateSpacePlanner<IntentionalProblem> {
	
	public static final Argument<PartialPlan> PARTIAL_PLAN = new Argument<PartialPlan>("partial_plan", "pp"){

		@Override
		@SuppressWarnings("unchecked")
		protected PartialPlan getValue(Object object, ArgumentMap arguments){
			if(object instanceof PartialPlan)
				return (PartialPlan) object;
			PartialPlan partial = PartialPlan.newInstance(Iterable.class.cast(object));
			arguments.set(this, partial);
			return partial;
		}
	};
	
	private final PDDLManager io;
	
	public Glaive(){
		super("Galive");
		this.io = new PDDLManager();
		this.io.install(com.stephengware.java.planware.io.pddl.adl.ADLRequirement.ADL);
		this.io.install(com.stephengware.java.planware.io.pddl.ax.AxiomsRequirement.AXIOMS);
		this.io.install(com.stephengware.java.planware.io.pddl.expvar.ExpressionVariablesRequirement.EXPRESSION_VARIABLES);
		this.io.install(com.stephengware.java.planware.io.pddl.intp.IntentionalityRequirement.INTENTIONALITY);
		this.io.install(com.stephengware.java.planware.io.pddl.del.DelegationRequirement.DELEGATION);
		this.io.install(new com.stephengware.java.planware.io.pddl.glaive.GlaivePlanExtension());
		this.io.install(new com.stephengware.java.planware.io.pddl.cpocl.CPOCLPlanExtension());
	}

	@Override
	public ArgumentMap makeArguments(){
		ArgumentMap arguments = super.makeArguments();
		arguments.set(IO_MANAGER, io);
		return arguments;
	}
	
	private static final Heuristic<GlaiveSearchNode> GLAIVE_HEURISTIC = new BestFirst<>(new GlaiveHeuristic<>());
	
	private static final Comparator<GlaiveSearchNode> GLAIVE_TIE_BREAKER = new GlaiveTieBreaker<GlaiveSearchNode>();

	@Override
	public Search search(ArgumentMap arguments){
		// Get arguments
		IntentionalProblem problem = arguments.get(PROBLEM);
		boolean debug = arguments.get(DEBUG);
		IntentionalStateSpace space = arguments.get(STATE_SPACE);
		AxiomTree axiomTree = arguments.get(AXIOM_TREE);
		PartialPlan remaining = arguments.get(PARTIAL_PLAN);
		// Create strategy
		GlaivePlan rootPlan = new GlaivePlan(problem.name + "-solution", problem, axiomTree);
		GlaiveSearchNode rootNode = new GlaiveSearchNode(rootPlan, remaining);
		GlaiveRelaxedPlanBuilder relaxedPlanner = new GlaiveRelaxedPlanBuilder(new IntentionGraph(space), problem.getGoal());
		relaxedPlanner.evaluate(rootNode);
		HeuristicSearch<GlaiveSearchNode> strategy = new HeuristicSearch<GlaiveSearchNode>(GLAIVE_HEURISTIC, GLAIVE_TIE_BREAKER, rootNode, debug);
		// Create search
		return new DefaultGlaiveSearch(strategy, relaxedPlanner, problem.getGoal());
	}
}
