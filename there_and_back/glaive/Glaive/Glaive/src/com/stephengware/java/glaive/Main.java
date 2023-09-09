package com.stephengware.java.glaive;

import java.io.File;
import java.io.PrintWriter;

import com.stephengware.java.cpocl.Utilities;
import com.stephengware.java.planware.Argument;
import com.stephengware.java.planware.ArgumentMap;
import com.stephengware.java.planware.CausalPath;
import com.stephengware.java.planware.IntentionalDomain;
import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.Plan;
import com.stephengware.java.planware.Search;
import com.stephengware.java.planware.Result;
import com.stephengware.java.planware.ss.IntentionalSimplifier;
import com.stephengware.java.planware.ss.IntentionalStateSpace;
import com.stephengware.java.planware.util.ImmutableList;

public class Main {

	public static void main(String[] args){
		System.out.println("The Glaive Narrative Planner, by Stephen G. Ware");
		if(findKey("help", args) != -1){
			System.out.println(USAGE);
			System.exit(0);
		}
		boolean needNewLine = false;
		try{
			Glaive planner = new Glaive();			ArgumentMap arguments = planner.makeArguments();
			setRequiredArgument(Glaive.DOMAIN, arguments, args);
			setRequiredArgument(Glaive.PROBLEM, arguments, args);
			File partialPlanFile = null;
			if(findKey("pp", args) != -1)
				partialPlanFile = new File(requireValue("pp", args));
			boolean simplify = false;
			if(findKey("s", args) != -1)
				simplify = true;
			File stateSpaceInputFile = null;
			if(findKey("rs", args) != -1)
				stateSpaceInputFile = new File(requireValue("rs", args));
			File stateSpaceOutputFile = null;
			if(findKey("ws", args) != -1)
				stateSpaceOutputFile = new File(requireValue("ws", args));
			boolean debug = false;
			if(findKey("b", args) != -1){
				debug = true;
				arguments.set(Glaive.DEBUG, debug);
			}
			setArgument(Glaive.STATE_SPACE, arguments, "rs", args);
			setArgument(Glaive.TIME_LIMIT, arguments, Glaive.TIME_LIMIT.abbreviation, args);
			setArgument(Glaive.SEARCH_LIMIT, arguments, Glaive.SEARCH_LIMIT.abbreviation, args);
			int n = 1;
			if(findKey("n", args) != -1)
				n = Integer.parseInt(requireValue("n", args));
			if(n < 1)
				throw new IllegalArgumentException("Illegal number of solutions: " + n);
			boolean verbose = false;
			if(findKey("v", args) != -1)
				verbose = true;
			boolean cpocl = false;
			if(findKey("cpocl", args) != -1)
				cpocl = true;
			File outputFile = null;
			if(findKey("o", args) != -1)
				outputFile = new File(requireValue("o", args));
			needNewLine = true;
			System.out.print("Reading domain............ ");
			IntentionalDomain domain = arguments.get(Glaive.DOMAIN);
			System.out.println(domain);
			System.out.print("Reading problem........... ");
			IntentionalProblem problem = arguments.get(Glaive.PROBLEM);
			System.out.println(problem);
			IntentionalStateSpace space;
			if(stateSpaceInputFile == null){
				System.out.print("Creating state space...... ");
				space = arguments.get(Glaive.STATE_SPACE);
				System.out.println(space);
			}
			else{
				System.out.print("Reading state space....... ");
				space = arguments.get(Glaive.IO_MANAGER).read(stateSpaceInputFile, IntentionalStateSpace.class);
				System.out.println(space);
			}
			if(simplify){
				System.out.print("Simplifying state space... ");
				space = IntentionalSimplifier.removeUnusedElements(space);
				space = IntentionalSimplifier.removeUnmotivatedElements(space);
				arguments.set(Glaive.STATE_SPACE, space);
				System.out.println(space);
			}
			if(partialPlanFile != null){
				System.out.print("Reading partial plan...... ");
				Plan partial = arguments.get(Glaive.IO_MANAGER).read(partialPlanFile, Plan.class);
				arguments.set(Glaive.PARTIAL_PLAN, partial.steps());
				System.out.println(partial);
			}
			needNewLine = false;
			if(stateSpaceOutputFile != null){
				arguments.get(Glaive.IO_MANAGER).write(space, stateSpaceOutputFile);
				System.out.println("State space written to file.");
				System.exit(0);
			}
			arguments.get(Glaive.AXIOM_TREE);
			Search search = planner.search(arguments);
			System.out.print("Planning ");
			if(debug)
				System.out.print("in debug mode ");
			System.out.print("with ");
			int timeLimit = arguments.get(Glaive.TIME_LIMIT);
			if(timeLimit == -1)
				System.out.print("no time limit and ");
			else
				System.out.print("a time limit of " + timeLimit + " milliseconds and ");
			int nodeLimit = arguments.get(Glaive.SEARCH_LIMIT);
			if(nodeLimit == -1)
				System.out.println("no search limit.");
			else
				System.out.println("a search limit of " + nodeLimit + " nodes.");
			Result result = search.getNextPlan(arguments);
			for(int i=1; i<n; i++)
				result = search.getNextPlan(arguments);
			if(result.getSuccess())
				System.out.print("A");
			else{
				search = null;
				System.gc();
				System.out.print("No");
			}
			System.out.println(" solution was found after " + result.timeToString() + "; " + result.getVisited() + " nodes were visited; " + result.getGenerated() + " were generated.");
			if(result.getSuccess()){
				Plan plan = result.getPlan();
				if(verbose)
					for(Subplan subplan : Utilities.getSubplans((GlaivePlan) plan))
						printGoalTree(subplan);
				if(cpocl)
					plan = Utilities.toCPOCL((GlaivePlan) plan);
				PrintWriter out = new PrintWriter(System.out);
				arguments.get(Glaive.IO_MANAGER).write(plan, out);
				out.flush();
				if(outputFile != null){
					arguments.get(Glaive.IO_MANAGER).write(plan, outputFile);
					System.out.println("\nSolution written to file.");
				}
			}
		}
		catch(Exception ex){
			if(needNewLine)
				System.out.println();
			System.out.println(ex);
			System.exit(1);
		}
	}
	
	private static final String USAGE =
			"Usage: java -jar glaive.jar -d <domain file> -p <problem file> [-options]\n" +
			"where options include:\n" +
			"  -help              Prints usage information.\n" +
			"  -pp <plan file>    Read a partial plan which must appear in the solution.\n" +
			"  -s                 Simplify the state space befor planning.\n" +
			"  -ws <output file>  Write the state space to a file and halt.\n" +
			"  -rs <space file>   Read the state space from a file.\n" +
			"  -b                 Debug mode: prints verbose description of each node visited.\n" +
			"  -tl <time>         Max number of milliseconds before aborting the search.\n" +
			"  -nl <nodes>        Max number of nodes to search before aborting.\n" +
			"  -n <number>        Return the nth solution found (default is 1).\n" +
			"  -v                 Prints a verbose explanation of every intentional chain.\n" +
			"  -cpocl             Output the solution as a Conflict Partial Order Causal Link plan.\n" +
			"  -o <output file>   Outputs the resulting plan to a file.\n" +
			"All input and output is in PDDL.";
	
	private static final int findKey(String key, String[] args){
		for(int i=0; i<args.length; i++)
			if(args[i].startsWith("-") && args[i].substring(1).equalsIgnoreCase(key))
				return i;
		return -1;
	}
	
	private static final String getValue(String key, String[] args){
		int keyIndex = findKey(key, args);
		if(keyIndex == -1 || keyIndex+1 == args.length)
			return null;
		else
			return args[keyIndex + 1];
	}
	
	private static final String requireValue(String key, String[] args){
		String value = getValue(key, args);
		if(value == null)
			throw new IllegalArgumentException("Value expected after key \"-" + key + "\". Consult -help for usage information.");
		return value;
	}
	
	private static final void setArgument(Argument<?> argument, ArgumentMap map, String key, String[] args){
		String value = getValue(key, args);
		if(value != null)
			map.set(argument, value);
	}
	
	private static final void setRequiredArgument(Argument<?> argument, ArgumentMap map, String[] args){
		if(findKey(argument.abbreviation, args) == -1)
			throw new IllegalArgumentException("The key \"-" + argument.abbreviation + "\" is missing. Consult -help for usage information.");
		String value = getValue(argument.abbreviation, args);
		if(value == null)
			throw new IllegalArgumentException("Value expected after key \"-" + argument.abbreviation + "\". Consult -help for usage information.");
		map.set(argument, value);
	}
	
	private static final void printGoalTree(Subplan subplan){
		printGoalTree(subplan.goal, subplan.goal.satisfaction, CausalPath.EMPTY, new ImmutableList<CausalLink>());
	}
	
	private static final void printGoalTree(AgentGoal goal, Event event, CausalPath path, ImmutableList<CausalLink> links){
		boolean top = true;
		if(event == null)
			return;
		for(CausalLink link : event.inLinks){
			if(goal.motivation.time < link.tail.time && !path.contains(link.label)){
				if(event instanceof StepEvent){
					top = false;
					if(((StepEvent) event).source.agents.contains(goal.agent))
						printGoalTree(goal, link.tail, path.add(link.label), links.add(link));
				}
				else{
					top = false;
					printGoalTree(goal, link.tail, path.add(link.label), links.add(link));
				}
			}
		}
		if(top){
			System.out.println("Causal chain for " + goal.agent + " to achieve " + goal.goal + ":");
			String indent = "";
			for(CausalLink link : links){
				indent += "  ";
				System.out.println(indent + link.tail.source + " achieves " + link.label + " at time " + link.tail.time);
			}
		}
	}
}