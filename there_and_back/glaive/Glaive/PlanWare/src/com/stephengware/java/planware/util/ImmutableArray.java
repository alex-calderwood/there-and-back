package com.stephengware.java.planware.util;

import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.RandomAccess;

public class ImmutableArray<T> implements CountableIterable<T>, RandomAccess {

	public final int length;
	protected final T[] array;
	private final int hashCode;
	
	@SuppressWarnings("unchecked")
	public ImmutableArray(T[] array){
		if(array == null){
			this.array = (T[]) new Object[0];
			this.length = 0;
			this.hashCode = 0;
		}
		else{
			this.array = array;
			this.length = array.length;
			this.hashCode = Arrays.hashCode(array);
		}
	}
	
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof ImmutableArray){
			T[] otherArray = ((ImmutableArray<T>) other).array;
			if(array.length != otherArray.length)
				return false;
			for(int i=0; i<array.length; i++)
				if(!array[i].equals(otherArray[i]))
					return false;
			return true;
		}
		return false;
	}
	
	@Override
	public int size(){
		return length;
	}
	
	public final T get(int index){
		return array[index];
	}
	
	public final boolean contains(T object){
		for(int i=0; i<length; i++)
			if(array[i].equals(object))
				return true;
		return false;
	}
	
	@Override
	public final Iterator<T> iterator(){
		return new ArrayIterator<T>(array);
	}
	
	public final T[] toArray(){
		return array.clone();
	}
	
	public final java.util.List<T> toList(){
		LinkedList<T> list = new LinkedList<>();
		for(T element : array)
			list.add(element);
		return list;
	}
}
