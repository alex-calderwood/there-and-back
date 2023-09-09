package com.stephengware.java.planware.io;

public class Field<T, F> {

	public final Class<T> objectType;
	public final String name;
	public final Class<F> fieldType;
	private final String string;
	
	public Field(Class<T> objectType, String name, Class<F> fieldType){
		this.objectType = objectType;
		this.name = name;
		this.fieldType = fieldType;
		this.string = objectType.getSimpleName() + "#" + name + "#" + fieldType.getSimpleName();
	}
	
	@Override
	public int hashCode(){
		return string.hashCode();
	}
	
	@Override
	public boolean equals(Object other){
		if(other instanceof Field){
			Field<?, ?> otherField = (Field<?, ?>) other;
			return objectType.equals(otherField.objectType) &&
					name.equals(otherField.name) &&
					fieldType.equals(otherField.fieldType);
		}
		return false;
	}
	
	@Override
	public String toString(){
		return string;
	}
}
