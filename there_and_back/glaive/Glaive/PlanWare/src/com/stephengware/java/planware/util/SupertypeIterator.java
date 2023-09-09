package com.stephengware.java.planware.util;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.NoSuchElementException;
import java.util.Queue;

public class SupertypeIterator<T> implements Iterator<Class<? super T>> {

	private final Queue<Class<? super T>> queue = new LinkedList<>();
	
	public SupertypeIterator(Class<T> subtype){
		queue.add(subtype);
		advance();
	}
	
	@SuppressWarnings("unchecked")
	private final Class<? super T> advance(){
		Class<? super T> subtype = queue.poll();
		Class<? super T> superclass = subtype.getSuperclass();
		if(superclass != null)
			queue.add(superclass);
		for(Class<?> superinterface : subtype.getInterfaces())
			queue.add((Class<? super T>) superinterface);
		return subtype;
	}
	
	@Override
	public boolean hasNext(){
		return !queue.isEmpty();
	}

	@Override
	public Class<? super T> next(){
		if(queue.isEmpty())
			throw new NoSuchElementException("The iterator is empty.");
		return advance();
	}

	@Override
	public void remove(){
		throw new UnsupportedOperationException("java.util.Iterator#Remove not supported.");
	}
}
