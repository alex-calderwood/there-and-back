package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.Iterator;

public interface Entity extends Comparable<Entity> {
		
	@Override
	public int hashCode();
		
	public Iterator<? extends Entity> iterator();
	
	public boolean isGround();
	
	public boolean occurs(Entity entity);
	
	public <E extends Entity> Collection<E> collect(Class<E> entityType);
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection);
	
	public boolean subsumes(Entity other, Taxonomy taxonomy);
	
	public abstract Entity substitute(Substitution substitution);
	
	public abstract String getDescription();
}
