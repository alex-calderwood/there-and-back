package com.stephengware.java.planware.logic;

public abstract class SubstitutionObject implements Substitution {

	@Override
	@SuppressWarnings("unchecked")
	public <E extends Entity> E substitute(Entity entity, Class<E> entityType){
		Entity substitution = substitute(entity);
		if(substitution == null)
			substitution = entity;
		if(entity != substitution)
			substitution = substitution.substitute(this);
		if(entityType.isAssignableFrom(substitution.getClass()))
			return (E) substitution;
		else
			throw new IllegalSubstitutionException(entity, substitution, entityType);
	}
	
	protected abstract Entity substitute(Entity entity);
}
