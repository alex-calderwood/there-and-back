package com.stephengware.java.planware.util;

public class ListNode<T> {

	public final T content;
	public ListNode<T> next;
	
	public ListNode(T content, ListNode<T> next){
		this.content = content;
		this.next = next;
	}
	
	@Override
	public String toString(){
		return content.toString();
	}
}
