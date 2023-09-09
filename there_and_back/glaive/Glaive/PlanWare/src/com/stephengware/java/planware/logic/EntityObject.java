package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;

import com.stephengware.java.planware.util.EmptyIterator;

public abstract class EntityObject implements Entity {
	
	protected static final Iterator<Entity> NO_ENTITIES = new EmptyIterator<Entity>();
	
	@Override
	public int compareTo(Entity entity){
		return toString().compareTo(entity.toString());
	}
	
	@Override
	public <E extends Entity> Collection<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<E>();
		collect(entityType, collection);
		return collection;
	}
	
	@Override
	public String getDescription(){
		return "logical entity";
	}
}
