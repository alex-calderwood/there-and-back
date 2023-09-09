package com.stephengware.java.planware.util;

public class List<T> extends AbstractList<T> {
	
	@Override
	public final List<T> add(T element){
		first = new ListNode<T>(element, first);
		length++;
		return this;
	}
	
	@Override
	public final List<T> remove(T element){
		if(first == null)
			return this;
		else if(first.content == element){
			first = first.next;
			length--;
		}
		else{
			ListNode<T> current = first;
			while(current.next != null){
				if(current.next.content.equals(element)){
					current.next = current.next.next;
					length--;
					return this;
				}
				current = current.next;
			}
		}
		return this;
	}
	
	@Override
	public final List<T> clear(){
		first = null;
		length = 0;
		return this;
	}
}
