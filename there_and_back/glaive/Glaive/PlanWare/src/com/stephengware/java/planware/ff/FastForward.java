package com.stephengware.java.planware.ff;

import com.stephengware.java.planware.ArgumentMap;
import com.stephengware.java.planware.HashState;
import com.stephengware.java.planware.ListPlan;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Search;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.io.pddl.PDDLManager;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.pg.PlanGraph;
import com.stephengware.java.planware.search.BestFirst;
import com.stephengware.java.planware.search.Heuristic;
import com.stephengware.java.planware.search.HeuristicSearch;
import com.stephengware.java.planware.ss.Simplifier;
import com.stephengware.java.planware.ss.StateSpace;
import com.stephengware.java.planware.ss.StateSpacePlanner;

public class FastForward extends StateSpacePlanner<Problem> {

	private static final Heuristic<FastForwardSearchNode> FAST_FORWARD_HEURISTIC = new FastForwardHeuristic();
	private final PDDLManager io;

	public FastForward(){
		super("Fast Forward");
		this.io = new PDDLManager();
		this.io.install(com.stephengware.java.planware.io.pddl.adl.ADLRequirement.ADL);
		this.io.install(com.stephengware.java.planware.io.pddl.ax.AxiomsRequirement.AXIOMS);
	}
	
	@Override
	public ArgumentMap makeArguments(){
		ArgumentMap arguments = super.makeArguments();
		arguments.set(IO_MANAGER, io);
		return arguments;
	}
	
	@Override
	public Search search(ArgumentMap arguments){
		Problem problem = arguments.get(PROBLEM);
		boolean debug = arguments.get(FastForward.DEBUG);
		StateSpace space = arguments.get(STATE_SPACE);
		System.out.println(space + "\n");
		System.out.println("Simplifying state space...\n");
		space = Simplifier.removeUnusedElements(space);
		System.out.println(space + "\n");
		State initialState = new HashState(arguments.get(AXIOM_TREE));
		initialState.impose(problem.getInitialState());
		System.out.println("Initial State: " + initialState);
		Expression goal = problem.getGoal();
		System.out.println("         Goal: " + goal + "\n");
		FastForwardSearchNode root = new FastForwardSearchNode(new ListPlan(problem.name + "-solution", problem), initialState);
		FastForwardRelaxedPlanBuilder relaxedPlanBuilder = new FastForwardRelaxedPlanBuilder(new PlanGraph(space), problem.getGoal());
		relaxedPlanBuilder.evaluate(root);
		HeuristicSearch<FastForwardSearchNode> strategy = new HeuristicSearch<>(new BestFirst<>(FAST_FORWARD_HEURISTIC), root, debug);
		return new FastForwardSearch(strategy, relaxedPlanBuilder, problem.getGoal());
	}
}