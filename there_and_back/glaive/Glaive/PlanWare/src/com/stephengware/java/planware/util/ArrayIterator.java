package com.stephengware.java.planware.util;

import java.util.NoSuchElementException;

public class ArrayIterator<T> implements java.util.Iterator<T> {

	private final T[] array;
	private int to;
	private int index = 0;
		
	public ArrayIterator(T[] array, int to){
		this.array = array;
		this.to = to;
	}
	
	@SafeVarargs
	public ArrayIterator(T...array){
		this(array, array.length);
	}
	
	@Override
	public boolean hasNext(){
		return index != to;
	}

	@Override
	public T next(){
		if(!hasNext())
			throw new NoSuchElementException("The iterator is empty.");
		index++;
		return array[index - 1];
	}

	@Override
	public void remove(){
		throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
	}
}
