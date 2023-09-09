package com.stephengware.java.planware.logic;

import java.util.Collection;
import java.util.Iterator;

import com.stephengware.java.planware.FormatException;

public class Constant extends EntityObject implements Term {
		
	public final String name;
	public final Type type;
	private final int hashCode;
	
	public Constant(String name, Type type){
		if(name == null)
			throw new FormatException(getDescription(), "Name cannot be null.");
		if(type == null)
			throw new FormatException(getDescription(), "Type cannot be null.");
		this.name = name.intern();
		this.type = type;
		this.hashCode = name.hashCode() + type.hashCode();
	}
	
	public Constant(String name){
		this(name, Type.UNIVERSAL_SUPERTYPE);
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Constant){
			Constant otherConstant = (Constant) other;
			if(!testCompatibility(otherConstant) || !otherConstant.testCompatibility(this))
				return false;
			return name == otherConstant.name && type == otherConstant.type;
		}
		return false;
	}
	
	protected boolean testCompatibility(Constant other){
		return true;
	}
	
	@Override
	public Iterator<? extends Entity> iterator(){
		return NO_ENTITIES;
	}
	
	@Override
	public boolean isGround(){
		return true;
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
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		return equals(other);
	}
	
	@Override
	public Term substitute(Substitution substitution){
		return substitution.substitute(this, Term.class);
	}
	
	@Override
	public String getName(){
		return name;
	}
	
	@Override
	public Type getType(){
		return type;
	}
	
	@Override
	public String toString(){
		return name;
	}
	
	@Override
	public String getDescription(){
		return "constant";
	}
}
