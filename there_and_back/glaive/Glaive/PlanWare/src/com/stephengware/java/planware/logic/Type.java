package com.stephengware.java.planware.logic;

import java.util.HashMap;

public final class Type {

	public static final Type UNIVERSAL_SUPERTYPE = new Type("object", 0);
	
	public final String name;
	public final int id;
	private final int hashCode;
	
	private static HashMap<String, Type> allTypes = new HashMap<String, Type>();
	private static int nextID = 1;
	
	static{
		allTypes.put(UNIVERSAL_SUPERTYPE.name, UNIVERSAL_SUPERTYPE);
	}
	
	public static final Type getType(String name){
		Type type = allTypes.get(name);
		if(type == null){
			type = new Type(name, nextID);
			nextID++;
			allTypes.put(name, type);
		}
		return type;
	}
	
	private Type(String name, int id){
		this.name = name;
		this.id = id;
		this.hashCode = name.hashCode() + id;
	}
	
	@Override
	public final int hashCode(){
		return hashCode;
	}
	
	@Override
	public final boolean equals(Object other){
		return this == other;
	}
	
	@Override
	public final String toString(){
		return name;
	}
}
