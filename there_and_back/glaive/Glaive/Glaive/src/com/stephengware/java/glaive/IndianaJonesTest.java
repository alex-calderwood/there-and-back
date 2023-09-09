package com.stephengware.java.glaive;

import java.io.File;
import java.util.ArrayList;

import com.stephengware.java.planware.ArgumentMap;
import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.Planner;
import com.stephengware.java.planware.Result;
import com.stephengware.java.planware.Search;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.ss.IntentionalSimplifier;
import com.stephengware.java.planware.ss.IntentionalStateSpace;

public class IndianaJonesTest {

	public static void main(String[] args) throws Exception {
		Glaive planner = new Glaive();
		ArgumentMap arguments = planner.makeArguments();
		arguments.set(Glaive.DOMAIN, "C:\\Users\\Stephen\\Documents\\Planning\\indiana-jones-ark-domain.pddl");
		arguments.set(Glaive.PROBLEM, "C:\\Users\\Stephen\\Documents\\Planning\\indiana-jones-ark-problem.pddl");
		// Simplify state space
		IntentionalStateSpace space = arguments.get(Glaive.STATE_SPACE);
		space = IntentionalSimplifier.removeUnusedElements(space);
		space = IntentionalSimplifier.removeUnmotivatedElements(space);
		arguments.get(Planner.IO_MANAGER).write(space, new File("C:\\Users\\Stephen\\Documents\\Planning\\indiana-jones-ark-space.pddl"));
		arguments.set(Glaive.STATE_SPACE, space);
		arguments.get(Glaive.AXIOM_TREE);
		// Create partial plan
		com.stephengware.java.planware.io.pddl.PDDLManager io = new com.stephengware.java.planware.io.pddl.PDDLManager();
		io.setProblem(arguments.get(Glaive.PROBLEM));
		ArrayList<IntentionalStep> partial = new ArrayList<>();
		partial.add(io.read("(take nazis ark indiana tanis)", IntentionalStep.class));
		arguments.set(Glaive.PARTIAL_PLAN, partial);
		// Plan
		Search search = planner.search(arguments);
		System.gc();
		System.out.println("Planning...\n");
		arguments.set(Planner.SEARCH_LIMIT, 1000);
		Result result = search.getNextPlan(arguments);
		System.out.println(result + "\n");
		if(result.getPlan() != null)
			for(Step step : result.getPlan().steps())
				System.out.println(step);
		result = search.getNextPlan(arguments);
		System.out.println("\n" + result + "\n");
		if(result.getPlan() != null)
			for(Step step : result.getPlan().steps())
				System.out.println(step);
	}
}
