package com.stephengware.java.planware.util;

import java.util.NoSuchElementException;

public class Queue<T> {

	protected final class Node {
		
		public final T content;
		public Node next;
		
		public Node(T content, Node next){
			this.content = content;
			this.next = next;
		}
	}
	
	protected Node first = null;
	protected Node last = null;
	protected int size = 0;
	
	public int size(){
		return size;
	}
	
	public boolean isEmpty(){
		return size == 0;
	}
	
	public T peek(){
		if(first == null)
			throw new NoSuchElementException("The queue is empty.");
		return first.content;
	}
	
	public void push(T element){
		if(last == null){
			first = new Node(element, null);
			last = first;
		}
		else{
			last.next = new Node(element, null);
			last = last.next;
		}
		size++;
	}
	
	public T pop(){
		if(first == null)
			throw new IndexOutOfBoundsException("The queue is empty.");
		T element = first.content;
		first = first.next;
		size--;
		if(size == 0)
			last = null;
		return element;
	}
}
