package com.stephengware.java.planware.util;

public class Edge<T> {

	public final T tail;
	public final T head;
	
	Edge(T tail, T head){
		this.tail = tail;
		this.head = head;
	}
}
