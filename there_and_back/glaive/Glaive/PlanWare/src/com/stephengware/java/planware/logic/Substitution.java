package com.stephengware.java.planware.logic;

public interface Substitution {
	
	public <E extends Entity> E substitute(Entity entity, Class<E> entityType);
}
