package com.stephengware.java.planware.logic;

import java.util.HashMap;
import java.util.Map;

import com.stephengware.java.planware.Universe;

public class HashSubstitution extends SubstitutionObject {

	private final Universe universe;
	private final HashMap<Entity, Entity> map = new HashMap<>();
	
	public HashSubstitution(Universe universe, Map<Entity, Entity> map){
		this.universe = universe;
		this.map.putAll(map);
	}
	
	public HashSubstitution(Universe universe){
		this.universe = universe;
	}
	
	public HashSubstitution(){
		this(null);
	}
	
	@Override
	protected Entity substitute(Entity entity){
		Entity substitution = map.get(entity);
		if(substitution == null && entity instanceof QuantifiedExpression)
			return ((QuantifiedExpression) entity).toUniversalBase(universe);
		return substitution;
	}
	
	public void replace(Entity original, Entity replacement){
		if(original == null || replacement == null)
			throw new IllegalArgumentException("Null values cannot be substituted.");
		map.put(original, replacement);
	}
}
