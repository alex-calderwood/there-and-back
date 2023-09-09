package com.stephengware.java.planware;

import com.stephengware.java.planware.io.IOManager;

public abstract class Planner<P extends Problem> {

	public static final Argument<IOManager<?, ?>> IO_MANAGER = new Argument<IOManager<?, ?>>("io_manager"){

		@Override
		protected IOManager<?, ?> getValue(Object object, ArgumentMap arguments){
			return IOManager.class.cast(object);
		}
	};
	
	public static final Argument<Domain> DOMAIN = new Argument.ParsedArgument<Domain>("domain", "d", Domain.class);
	
	public static final Argument<Problem> PROBLEM = new Argument.ParsedArgument<Problem>("problem", "p", Problem.class){
		
		@Override
		protected Problem getValue(Object object, ArgumentMap arguments){
			arguments.get(DOMAIN);
			return super.getValue(object, arguments);
		}
	};

	public static final Argument<Boolean> DEBUG = new Argument.BooleanArgument("debug", "g", false);
	
	public static final Argument<Integer> TIME_LIMIT = new Argument.IntegerArgument("time_limit", "tl", -1);
	
	public static final Argument<Integer> SEARCH_LIMIT = new Argument.IntegerArgument("search_limit", "nl", -1);
	
	public final String name;
	
	public Planner(String name){
		this.name = name;
	}
	
	public ArgumentMap makeArguments(){
		return new ArgumentMap();
	}

	public abstract Search search(ArgumentMap arguments);
}
