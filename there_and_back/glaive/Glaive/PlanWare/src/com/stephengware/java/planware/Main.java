package com.stephengware.java.planware;

import java.io.FileNotFoundException;
import java.io.IOException;

import com.stephengware.java.planware.ff.FastForward;
import com.stephengware.java.planware.io.*;

public class Main {
	
	public static void main(String[] args) throws FileNotFoundException, IOException, ParseException, BuildException {
		FastForward planner = new FastForward();
		ArgumentMap arguments = planner.makeArguments();
		arguments.set(FastForward.DOMAIN, "C:\\Users\\Stephen\\Documents\\Planning\\blocks-axioms-domain.pddl");
		arguments.set(FastForward.PROBLEM, "C:\\Users\\Stephen\\Documents\\Planning\\blocks-axioms-sussman-problem.pddl");
		Search search = planner.search(arguments);
		arguments.set(Planner.TIME_LIMIT, 5000);
		Result result = search.getNextPlan(arguments);
		System.out.println(result + "\n");
		if(result.getPlan() != null)
			for(Step step : result.getPlan().steps())
				System.out.println(step);
	}
}