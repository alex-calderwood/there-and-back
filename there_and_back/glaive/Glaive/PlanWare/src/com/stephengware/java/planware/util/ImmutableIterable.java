package com.stephengware.java.planware.util;

import java.util.Iterator;

public class ImmutableIterable<T> implements Iterable<T> {

	private final Iterable<T> iterable;
	
	public ImmutableIterable(Iterable<T> iterable){
		this.iterable = iterable;
	}
	
	@Override
	public Iterator<T> iterator(){
		return new ImmutableIterator<T>(iterable.iterator());
	}
}
