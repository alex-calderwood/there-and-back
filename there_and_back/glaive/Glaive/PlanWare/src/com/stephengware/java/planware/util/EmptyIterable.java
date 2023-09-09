package com.stephengware.java.planware.util;

import java.util.Iterator;

public class EmptyIterable<T> implements CountableIterable<T> {

	private final EmptyIterator<T> iterator = new EmptyIterator<T>();
	
	@Override
	public int size(){
		return 0;
	}
	
	@Override
	public Iterator<T> iterator(){
		return iterator;
	}
}
