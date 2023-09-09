package com.stephengware.java.planware;

import java.util.concurrent.TimeUnit;

public abstract class Result {

	public abstract boolean getSuccess();
	
	public abstract Plan getPlan();
	
	public abstract long getTime();
	
	public abstract int getVisited();
	
	public abstract int getGenerated();
	
	public String timeToString(){
		long hours = TimeUnit.MILLISECONDS.toHours(getTime());
		long minutes = TimeUnit.MILLISECONDS.toMinutes(getTime()) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(getTime()));
		long seconds = TimeUnit.MILLISECONDS.toSeconds(getTime()) - TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(getTime()));
		long milliseconds = TimeUnit.MILLISECONDS.toMillis(getTime()) - TimeUnit.SECONDS.toMillis(TimeUnit.MILLISECONDS.toSeconds(getTime()));
		String str = "";
		boolean include = false;
		if(hours >= 1){
			str += hours + " hours ";
			include = true;
		}
		if(minutes >= 1 || include)
			str += minutes + " minutes ";
		return str + String.format("%d.%03d seconds", seconds, milliseconds);
	}
	
	@Override
	public String toString(){
		String str = "[Result: ";
		if(getSuccess())
			str += "success";
		else
			str += "failure";
		str += " after " + getTime() + "ms;";
		str += " " + getVisited() + " visited, " + getGenerated() + " generated]";
		return str;
	}
}
