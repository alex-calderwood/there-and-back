package com.stephengware.java.planware.util;

import java.lang.reflect.Array;
import java.util.LinkedHashSet;
import java.util.Set;

public class ImmutableSet<T> extends ImmutableArray<T> {

	public ImmutableSet(T[] array){
		super(removeDuplicates(array));
	}
	
	@SuppressWarnings("unchecked")
	public ImmutableSet(Set<T> set, Class<T> objectType){
		super(set.toArray((T[]) Array.newInstance(objectType, set.size())));
	}
	
	@SuppressWarnings("unchecked")
	private static final <T> T[] removeDuplicates(T[] array){
		if(array == null)
			return null;
		LinkedHashSet<T> set = new LinkedHashSet<>();
		for(T object : array)
			set.add(object);
		return set.toArray((T[]) Array.newInstance(array.getClass().getComponentType(), set.size()));
	}

	@Override
	@SuppressWarnings("unchecked")
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof ImmutableSet){
			ImmutableSet<T> otherSet = (ImmutableSet<T>) other;
			int count = 0;
			for(T element : array){
				if(otherSet.contains(element))
					count++;
				else
					return false;
			}
			return count == otherSet.length;
		}
		return false;
	}
}
