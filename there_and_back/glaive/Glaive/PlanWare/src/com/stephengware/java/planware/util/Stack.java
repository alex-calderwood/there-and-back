package com.stephengware.java.planware.util;

import java.util.NoSuchElementException;

public class Stack<T> {

	protected final class Node {
		
		public final T content;
		public Node next;
		
		public Node(T content, Node next){
			this.content = content;
			this.next = next;
		}
	}
	
	protected Node first = null;
	protected int size = 0;
	
	public int size(){
		return size;
	}
	
	public boolean isEmpty(){
		return size == 0;
	}
	
	public T peek(){
		if(first == null)
			throw new NoSuchElementException("The stack is empty.");
		return first.content;
	}
	
	public void push(T element){
		first = new Node(element, first);
		size++;
	}
	
	public T pop(){
		if(first == null)
			throw new IndexOutOfBoundsException("The stack is empty.");
		T element = first.content;
		first = first.next;
		size--;
		return element;
	}
}
