package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;

import com.stephengware.java.planware.FormatException;

public abstract class Variable extends EntityObject {
	
	private static final HashSet<String> allVariableNames = new HashSet<String>();
	private static int uniqueSuffix = 1;
	
	public final String name;
	private final int hashCode;
	
	public Variable(String name){
		if(name == null)
			throw new FormatException(getDescription(), "Name cannot be null.");
		this.name = name.intern();
		allVariableNames.add(this.name);
		this.hashCode = name.hashCode();
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public Iterator<? extends Entity> iterator(){
		return NO_ENTITIES;
	}
	
	@Override
	public boolean isGround(){
		return false;
	}
	
	@Override
	public boolean occurs(Entity entity){
		return equals(entity);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		if(entityType.isAssignableFrom(getClass()))
			collection.add((E) this);
	}

	protected final String getUniqueName(){
		String name = this.name;
		while(allVariableNames.contains(name)){
			name = this.name + "-" + Integer.toString(uniqueSuffix);
			uniqueSuffix++;
		}
		name = name.intern();
		allVariableNames.add(name);
		return name;
	}
	
	public abstract Variable newInstance();
	
	public abstract boolean subsumes(Entity other, Taxonomy taxonomy);
	
	@Override
	public String toString(){
		return "?" + name;
	}
	
	@Override
	public String getDescription(){
		return "variable";
	}
}
