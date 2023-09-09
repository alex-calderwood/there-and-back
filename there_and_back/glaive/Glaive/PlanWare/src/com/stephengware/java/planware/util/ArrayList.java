package com.stephengware.java.planware.util;

import java.util.Arrays;
import java.util.Iterator;

public class ArrayList<T> implements CountableIterable<T> {

	public static final int DEFAULT_INITIAL_CAPACITY = 10;
	
	private int size = 0;
	private T[] elements;
	
	@SuppressWarnings("unchecked")
	public ArrayList(int initialCapacity){
		elements = (T[]) new Object[initialCapacity];
	}
	
	public ArrayList(){
		this(DEFAULT_INITIAL_CAPACITY);
	}
	
	public void ensureCapacity(int capacity){
		if(elements.length < capacity)
			elements = Arrays.copyOf(elements, capacity);
	}
	
	@Override
	public int size(){
		return size;
	}

	public void add(T element){
		ensureCapacity(size + 1);
		elements[size] = element;
		size++;
	}
	
	public T get(int index){
		if(index < 0 || index >= size)
			throw new IndexOutOfBoundsException("Index out of bounds: " + index);
		return (T) elements[index];
	}

	public void clear(){
		size = 0;
	}
	
	@Override
	public Iterator<T> iterator(){
		return new ArrayIterator<T>(elements, size);
	}
}
