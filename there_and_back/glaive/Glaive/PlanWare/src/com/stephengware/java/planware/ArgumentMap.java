package com.stephengware.java.planware;

import java.util.HashMap;

public class ArgumentMap {

	private final HashMap<Argument<?>, Object> map = new HashMap<>();
	
	ArgumentMap(){}
	
	public void set(Argument<?> argument, Object value){
		map.put(argument, value);
	}
	
	public <T> T get(Argument<T> argument){
		return argument.getValue(map.get(argument), this);
	}
}
