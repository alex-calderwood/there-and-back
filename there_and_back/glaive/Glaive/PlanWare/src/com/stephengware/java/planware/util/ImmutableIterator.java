package com.stephengware.java.planware.util;

import java.util.Iterator;

public class ImmutableIterator<T> implements Iterator<T> {

	private final Iterator<T> iterator;
	
	public ImmutableIterator(Iterator<T> iterator){
		this.iterator = iterator;
	}
	
	@Override
	public boolean hasNext(){
		return iterator.hasNext();
	}

	@Override
	public T next(){
		return iterator.next();
	}

	@Override
	public void remove(){
		throw new UnsupportedOperationException("java.util.Iterator#remove not supported.");
	}
}
