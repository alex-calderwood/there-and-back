package com.stephengware.java.planware.util;

public class ImmutableList<T> extends AbstractList<T> {

	protected ImmutableList(ListNode<T> first, int length){
		super(first, length);
	}
	
	protected ImmutableList<T> makeList(ListNode<T> first, int length){
		return new ImmutableList<T>(first, length);
	}
		
	public ImmutableList(){
		super();
	}
	
	@Override
	public ImmutableList<T> add(T element){
		return makeList(new ListNode<T>(element, first), length + 1);
	}
	
	@Override
	public ImmutableList<T> remove(T element){
		ListNode<T> newFirst = remove(first, element);
		if(first == newFirst)
			return this;
		else return new ImmutableList<T>(newFirst, length - 1);
	}
	
	protected final ListNode<T> remove(ListNode<T> current, T element){
		if(current == null)
			return null;
		else if(current.content.equals(element))
			return current.next;
		else{
			ListNode<T> next = remove(current.next, element);
			if(current.next == next)
				return current;
			else
				return new ListNode<T>(current.content, next);
		}
	}
	
	@Override
	public ImmutableList<T> clear(){
		return new ImmutableList<T>(null, 0);
	}
}
