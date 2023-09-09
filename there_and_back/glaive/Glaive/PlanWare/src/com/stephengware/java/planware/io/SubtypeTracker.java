package com.stephengware.java.planware.io;

import java.util.HashMap;
import java.util.LinkedList;

class SubtypeTracker {

	private final HashMap<Class<?>, LinkedList<Class<?>>> subtypes = new HashMap<>();
	
	public void add(Class<?> objectType){
		registerSupertypes(objectType);
	}
	
	private final void registerSupertypes(Class<?> subtype){
		if(subtype == null)
			return;
		if(!subtypes.containsKey(subtype))
			subtypes.put(subtype, new LinkedList<Class<?>>());
		if(subtype.getSuperclass() != null && registerRelationship(subtype.getSuperclass(), subtype))
			registerSupertypes(subtype.getSuperclass());
		for(Class<?> supertype : subtype.getInterfaces()){
			if(registerRelationship(supertype, subtype))
				registerSupertypes(supertype);
		}
	}
	
	private final boolean registerRelationship(Class<?> supertype, Class<?> subtype){
		LinkedList<Class<?>> subtypes = this.subtypes.get(supertype);
		if(subtypes == null){
			subtypes = new LinkedList<Class<?>>();
			this.subtypes.put(supertype, subtypes);
		}
		if(subtypes.contains(subtype))
			return false;
		subtypes.add(subtype);
		return true;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public <O> Iterable<Class<? extends O>> getKnownSubtypes(Class<O> objectType){
		LinkedList subtypes = this.subtypes.get(objectType);
		if(subtypes == null){
			subtypes = new LinkedList<>();
			this.subtypes.put(objectType, subtypes);
		}
		return (Iterable<Class<? extends O>>) subtypes;
	}
}
