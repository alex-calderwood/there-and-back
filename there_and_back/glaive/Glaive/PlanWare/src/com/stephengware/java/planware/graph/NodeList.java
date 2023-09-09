package com.stephengware.java.planware.graph;

import java.util.Arrays;
import java.util.Iterator;
import java.util.RandomAccess;

import com.stephengware.java.planware.util.ArrayIterator;
import com.stephengware.java.planware.util.CountableIterable;

public class NodeList<N extends Node> implements CountableIterable<N>, RandomAccess {

	@SuppressWarnings("unchecked")
	private N[] array = (N[]) new Node[0];
	
	@Override
	public final int size(){
		return array.length;
	}
	
	public final N get(int index){
		return array[index];
	}
	
	public final boolean contains(N node){
		for(Node n : array)
			if(n == node)
				return true;
		return false;
	}
	
	protected final void add(N node){
		array = (N[]) Arrays.copyOf(array, array.length + 1);
		array[array.length - 1] = node;
	}
	
	@Override
	public Iterator<N> iterator(){
		return new ArrayIterator<N>(array);
	}
}
