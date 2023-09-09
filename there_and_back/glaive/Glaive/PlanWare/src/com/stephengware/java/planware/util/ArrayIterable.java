package com.stephengware.java.planware.util;

import java.util.Iterator;

public class ArrayIterable<T> implements CountableIterable<T> {

	private final T[] array;
	private final int to;
	
	public ArrayIterable(T[] array, int to){
		this.array = array;
		this.to = to;
	}
	
	public ArrayIterable(T[] array){
		this(array, array.length);
	}
	
	@Override
	public int size(){
		return to;
	}
	
	@Override
	public Iterator<T> iterator(){
		return new ArrayIterator<T>(array, to);
	}
}
