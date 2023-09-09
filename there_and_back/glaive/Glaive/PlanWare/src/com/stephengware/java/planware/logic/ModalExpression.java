package com.stephengware.java.planware.logic;

import java.util.Iterator;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.util.ImmutableArray;

public abstract class ModalExpression extends EntityObject implements Expression {
		
	public final String modality;
	protected final ImmutableArray<Entity> arguments;
	private int hashCode;
	
	public ModalExpression(String modality, Entity...arguments){
		if(modality == null)
			throw new FormatException(getDescription(), "Modality cannot be null.");
		this.modality = modality.intern();
		for(int i=0; i<arguments.length; i++){
			if(arguments[i] == null)
				throw new FormatException(getDescription(), "Argument " + (i + 1) + " cannot be null.");
		}
		this.arguments = new ImmutableArray<Entity>(arguments);
		int hc = modality.hashCode();
		for(Entity argument : arguments)
			hc = 31 * hc + argument.hashCode();
		this.hashCode = hc;
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof ModalExpression){
			ModalExpression otherModal = (ModalExpression) other;
			if(!testCompatibility(otherModal) || !otherModal.testCompatibility(this))
				return false;
			if(modality != otherModal.modality || arguments.length != otherModal.arguments.length)
				return false;
			for(int i=0; i<arguments.length; i++)
				if(!arguments.get(i).equals(otherModal.arguments.get(i)))
					return false;
			return true;
		}
		return false;
	}
	
	protected boolean testCompatibility(ModalExpression other){
		return true;
	}
	
	@Override
	public Iterator<? extends Entity> iterator(){
		return arguments.iterator();
	}

	@Override
	public boolean isGround(){
		for(int i=0; i<arguments.length; i++)
			if(!arguments.get(i).isGround())
				return false;
		return true;
	}

	@Override
	public boolean occurs(Entity entity){
		if(equals(entity))
			return true;
		for(int i=0; i<arguments.length; i++)
			if(arguments.get(i).occurs(entity))
				return true;
		return false;
	}
	
	@Override
	public boolean subsumes(Entity other, Taxonomy taxonomy){
		if(other instanceof ModalExpression){
			ModalExpression otherModalExpression = (ModalExpression) other;
			if(!modality.equals(otherModalExpression.modality) || arguments.length != otherModalExpression.arguments.length)
				return false;
			for(int i=0; i<arguments.length; i++)
				if(!arguments.get(i).subsumes(otherModalExpression.arguments.get(i), taxonomy))
					return false;
			return true;
		}
		return false;
	}
	
	protected Entity[] substituteArguments(Substitution substitution){
		for(int i=0; i<arguments.length; i++){
			Entity substitutedArgument = arguments.get(i).substitute(substitution);
			if(substitutedArgument != arguments.get(i)){
				Entity[] substitutedArguments = new Entity[arguments.length];
				for(int j=0; j<i; j++)
					substitutedArguments[j] = arguments.get(j);
				substitutedArguments[i] = substitutedArgument;
				for(int j=i+1; j<arguments.length; j++)
					substitutedArguments[j] = arguments.get(j).substitute(substitution);
				return substitutedArguments;
			}
		}
		return null;
	}
	
	@Override
	public String toString(){
		String str = "(" + modality;
		for(int i=0; i<arguments.length; i++)
			str += " " + arguments.get(i);
		return str + ")";
	}
	
	@Override
	public String getDescription(){
		return "modal expression";
	}
}
