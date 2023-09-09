package com.stephengware.java.planware.logic;

import com.stephengware.java.planware.FormatException;

public class TermVariable extends Variable implements Term {
	
	public final Type type;
	private final int hashCode;
	
	public TermVariable(String name, Type type){
		super(name);
		if(type == null)
			throw new FormatException(getDescription(), "Type cannot be null.");
		this.type = type;
		this.hashCode = name.hashCode() + type.hashCode();
	}
	
	public TermVariable(String name){
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
		else if(other instanceof TermVariable){
			TermVariable otherTermVariable = (TermVariable) other;
			if(!testCompatibility(otherTermVariable) || !otherTermVariable.testCompatibility(this))
				return false;
			return name == otherTermVariable.name && type == otherTermVariable.type;
		}
		return false;
	}
	
	protected boolean testCompatibility(TermVariable other){
		return true;
	}
	
	@Override
	public boolean occurs(Entity entity){
		return equals(entity);
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof Term)
			return taxonomy.hasRelationship(type, ((Term) other).getType());
		else
			return false;
	}

	@Override
	public Term substitute(Substitution substitution){
		return substitution.substitute(this, Term.class);
	}
	
	@Override
	public TermVariable newInstance(){
		return new TermVariable(getUniqueName(), type);
	}
	
	@Override
	public String getName(){
		return name;
	}
	
	@Override
	public Type getType(){
		return type;
	}
}