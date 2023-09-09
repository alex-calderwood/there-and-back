package com.stephengware.java.planware.search;

import com.stephengware.java.planware.Plan;

public class Result extends com.stephengware.java.planware.Result {

	boolean success = false;
	Plan plan = null;
	long time = 0;
	int visited = 0;
	int generated = 0;
	
	@Override
	public boolean getSuccess(){
		return success;
	}

	@Override
	public Plan getPlan(){
		return plan;
	}

	@Override
	public long getTime(){
		return time;
	}

	@Override
	public int getVisited(){
		return visited;
	}

	@Override
	public int getGenerated(){
		return generated;
	}
}
