package com.stephengware.java.planware.util;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Iterator;

public final class Hashtable<K, V> {

	private static final int DEFAULT_INITIAL_CAPACITY = 5;
	private static final int EXPANSION_FACTOR = 2;
	private static final float LOAD_FACTOR_THRESHOLD = .75f;
	
	private final class Node {
		
		public K key;
		public V value;
		public Node next;

		public Node(K key, V value, Node next){
			this.key = key;
			this.value = value;
			this.next = next;
		}
	}
	
	private int size = 0;
	private Node[] table;
	
	@SuppressWarnings("unchecked")
	public Hashtable(int initialCapacity){
		initialCapacity = Math.max(1, initialCapacity);
		this.table = (Node[]) Array.newInstance(Node.class, initialCapacity * 2);
	}
	
	public Hashtable(){
		this(DEFAULT_INITIAL_CAPACITY);
	}
	
	private static final int bucket(Object obj, int tableLength){
		int b = obj.hashCode() % tableLength;
		if(b < 0) return b * -1;
		else return b;
	}
	
	private final float loadFactor(){
		return ((float) size) / table.length;
	}
	
	private final Node[] rehash(){
		Node[] newTable = Arrays.copyOf(Arrays.copyOf(table, 0), table.length * EXPANSION_FACTOR);
		Node current;
		int bucket;
		for(int i=0; i<table.length; i++){
			current = table[i];
			while(current != null){
				bucket = bucket(current.key, newTable.length);
				newTable[bucket] = new Node(current.key, current.value, newTable[bucket]);
				current = current.next;
			}
		}
		return newTable;
	}
	
	public final int size(){
		return size;
	}
	
	public final void put(K key, V value){
		if(loadFactor() > LOAD_FACTOR_THRESHOLD)
			table = rehash();
		int bucket = bucket(key, table.length);
		Node current = table[bucket];
		while(current != null){
			if(current.key == key){
				current.value = value;
				return;
			}
			current = current.next;
		}
		table[bucket] = new Node(key, value, table[bucket]);
		size++;
	}
	
	public final V get(K key){
		int bucket = bucket(key, table.length);
		Node current = table[bucket];
		while(current != null){
			if(current.key == key)
				return current.value;
			current = current.next;
		}
		return null;
	}
	
	public final void remove(K key){
		int bucket = bucket(key, table.length);
		Node current = table[bucket];
		if(current == null)
			return;
		if(current.key == key){
			table[bucket] = current.next;
			return;
		}
		while(current.next != null){
			if(current.next.key == key){
				current.next = current.next.next;
				return;
			}
			current = current.next;
		}
	}
	
	public final void clear(){
		size = 0;
		for(int i=0; i<table.length; i++)
			table[i] = null;
	}
	
	private abstract class HashIterator {
		
		private int index = 0;
		protected Node currentNode;
		
		protected HashIterator(){
			while(index < table.length && table[index] == null)
				index++;
			if(index < table.length)
				currentNode = table[index];
		}
		
		public final boolean hasNext(){
			return currentNode != null;
		}
		
		protected final void advance(){
			currentNode = currentNode.next;
			if(currentNode == null && index != table.length - 1){
				index++;
				while(index < table.length && table[index] == null)
					index++;
				if(index < table.length)
					currentNode = table[index];
			}
		}
		
		public final void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}
	
	private class KeyIterator extends HashIterator implements Iterator<K> {
			
		@Override
		public K next(){
			K key = currentNode.key;
			advance();
			return key;
		}
	}
	
	private class KeySet implements Iterable<K> {

		@Override
		public Iterator<K> iterator(){
			return new KeyIterator();
		}
	}
	
	private final KeySet myKeys = new KeySet();
	
	public Iterable<K> keys(){
		return myKeys;
	}
	
	private class ValueIterator extends HashIterator implements Iterator<V> {
				
		@Override
		public V next(){
			V value = currentNode.value;
			advance();
			return value;
		}
	}
	
	private class ValueSet implements Iterable<V> {

		@Override
		public Iterator<V> iterator(){
			return new ValueIterator();
		}
	}
	
	private final ValueSet myValues = new ValueSet();
	
	public Iterable<V> values(){
		return myValues;
	}
	
	public final K[] keysToArray(K[] array){
		array = Arrays.copyOf(array, size);
		Iterator<K> keys = new KeyIterator();
		for(int i=0; i<size; i++)
			array[i] = keys.next();
		return array;
	}
	
	public final V[] valuesToArray(V[] array){
		array = Arrays.copyOf(array, size);
		Iterator<V> keys = new ValueIterator();
		for(int i=0; i<size; i++)
			array[i] = keys.next();
		return array;
	}
	
	@Override
	public final String toString(){
		String str = "Hashtable with " + size + " entries";
		for(int i=0; i<table.length; i++){
			str += "\n[" + i + "]:";
			Node current = table[i];
			while(current != null){
				str += " (" + current.key + " " + current.key.hashCode() + ") => " + current.value;
				current = current.next;
			}
		}
		return str;
	}
}
