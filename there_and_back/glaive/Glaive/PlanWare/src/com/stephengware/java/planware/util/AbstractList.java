package com.stephengware.java.planware.util;

import java.util.Arrays;
import java.util.Iterator;
import java.util.NoSuchElementException;

public abstract class AbstractList<T> implements CountableIterable<T> {

	protected ListNode<T> first = null;
	protected int length = 0;
	
	protected AbstractList(ListNode<T> first, int length){
		this.first = first;
		this.length = length;
	}
	
	public AbstractList(){
		this(null, 0);
	}
	
	@Override
	public final int size(){
		return length;
	}
	
	public final boolean contains(T element){
		ListNode<T> current = first;
		while(current != null){
			if(current.content.equals(element))
				return true;
			current = current.next;
		}
		return false;
	}
	
	public final T getLast(){
		if(first == null)
			return null;
		else
			return first.content;
	}
	
	public final T get(int index){
		if(index >= length || index < 0)
			throw new IndexOutOfBoundsException("Cannot get element " + index + "; only " + length + " exist.");
		index = length - index - 1;
		ListNode<T> current = first;
		while(index != 0){
			current = current.next;
			index--;
		}
		return current.content;
	}
	
	public abstract AbstractList<T> add(T element);
	
	public abstract AbstractList<T> remove(T element);
	
	public abstract AbstractList<T> clear();
	
	private final class ListIterator implements Iterator<T> {

		private ListNode<T> current = first;
				
		@Override
		public boolean hasNext(){
			return current != null;
		}

		@Override
		public T next(){
			if(current == null)
				throw new NoSuchElementException("The iterator has no more elements.");
			T content = current.content;
			current = current.next;
			return content;
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}
	
	@Override
	public final Iterator<T> iterator(){
		return new ListIterator();
	}
	
	public final T[] toArray(T[] array){
		array = Arrays.copyOf(array, length);
		ListNode<T> current = first;
		for(int i=length-1; i!=-1; i--){
			array[i] = current.content;
			current = current.next;
		}
		return array;
	}
	
	@Override
	public String toString(){
		String str = "[";
		ListNode<T> node = first;
		while(node != null){
			str += node.content;
			if(node.next != null)
				str += ", ";
			node = node.next;
		}
		return str + "]";
	}
}
