package com.stephengware.java.planware.util;

import java.util.Iterator;

public class EmptyIterator<T> implements Iterator<T> {

	@Override
	public boolean hasNext(){
		return false;
	}

	@Override
	public T next(){
		throw new IndexOutOfBoundsException("Iterator is empty.");
	}

	@Override
	public void remove(){
		throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
	}
}
