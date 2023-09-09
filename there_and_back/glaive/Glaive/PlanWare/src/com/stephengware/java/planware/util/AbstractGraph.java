package com.stephengware.java.planware.util;

import java.util.Iterator;
import java.util.NoSuchElementException;

public abstract class AbstractGraph<T> implements Cloneable {
	
	protected static final int UNVISITED = -1;
	protected static final int FIRST_MARK = 1;
	protected static final int SECOND_MARK = 2;
	
	protected class Node {
		
		public final T content;
		public int visited = UNVISITED;
		public final NeighborList neighbors = new NeighborList();
		
		public Node(T content){
			this.content = content;
		}
	}
	
	protected class NeighborList implements Iterable<Node> {
		
		public class Neighbor {
			
			public final Node node;
			public int support = 1;
			public Neighbor next;
			
			public Neighbor(Node node, Neighbor next){
				this.node = node;
				this.next = next;
			}
		}
		
		public Neighbor first = null;
		
		public boolean contains(Node node){
			Neighbor neighbor = first;
			while(neighbor != null){
				if(neighbor.node == node)
					return true;
				neighbor = neighbor.next;
			}
			return false;
		}
		
		public void link(Node node){
			Neighbor neighbor = first;
			while(neighbor != null){
				if(neighbor.node == node){
					neighbor.support++;
					return;
				}
				neighbor = neighbor.next;
			}
			first = new Neighbor(node, first);
		}
		
		public void unlink(Node node){
			if(first.node == node){
				if(first.support == 1)
					first = first.next;
				else
					first.support--;
			}
			else{
				Neighbor neighbor = first;
				while(neighbor.next != null){
					if(neighbor.next.node == node){
						if(neighbor.next.support == 1)
							neighbor.next = neighbor.next.next;
						else
							neighbor.next.support--;
						return;
					}
					neighbor = neighbor.next;
				}
			}
		}
		
		public void remove(Node node){
			if(first.node == node)
				first = first.next;
			else{
				Neighbor neighbor = first;
				while(neighbor.next != null){
					if(neighbor.next.node == node){
						neighbor.next = neighbor.next.next;
						return;
					}
					neighbor = neighbor.next;
				}
			}
		}
		
		private final class NeighborIterator implements Iterator<Node> {

			private Neighbor neighbor;
			
			public NeighborIterator(){
				this.neighbor = first;
			}
			
			@Override
			public final boolean hasNext(){
				return neighbor != null;
			}

			@Override
			public final Node next(){
				if(neighbor == null)
					throw new NoSuchElementException("The iterator has no more elements.");
				Node node = neighbor.node;
				neighbor = neighbor.next;
				return node;
			}

			@Override
			public final void remove(){
				throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
			}
		}

		@Override
		public Iterator<Node> iterator(){
			return new NeighborIterator();
		}
	}
	
	protected abstract Node getNode(T element);
	
	public boolean hasNode(T element){
		return getNode(element) != null;
	}
		
	public abstract void addNode(T content);
	
	public abstract void removeNode(T content);
	
	public abstract int countNodes();
	
	public abstract Iterable<T> nodes();

	public boolean hasEdge(T tail, T head){
		return getNode(tail).neighbors.contains(getNode(head));
	}
	
	public abstract int countEdges();
	
	public abstract void addEdge(T tail, T head);
	
	public abstract void removeEdge(T tail, T head);
	
	public final void removeEdge(Edge<T> edge){
		removeEdge(edge.tail, edge.head);
	}
	
	public abstract Iterable<Edge<T>> edges();
	
	@Override
	public abstract Object clone();
	
	//-------------------------------------------------------------------------
	// Search
	//-------------------------------------------------------------------------
	
	protected final void dfMark(Node current, int mark){
		current.visited = mark;
		com.stephengware.java.planware.util.AbstractGraph<T>.NeighborList.Neighbor neighbor = current.neighbors.first;
		while(neighbor != null){
			if(neighbor.node.visited != mark)
				dfMark(neighbor.node, mark);
			neighbor = neighbor.next;
		}
	}
	
	protected final boolean dfSearchForMark(Node current, int mark, int goal){
		if(current.visited == goal)
			return true;
		current.visited = mark;
		com.stephengware.java.planware.util.AbstractGraph<T>.NeighborList.Neighbor neighbor = current.neighbors.first;
		while(neighbor != null){
			if(neighbor.node.visited != mark && dfSearchForMark(neighbor.node, mark, goal))
				return true;
			neighbor = neighbor.next;
		}
		return false;
	}
	
	protected final boolean dfSearchForNode(Node current, int mark, Node goal){
		if(current == goal)
			return true;
		current.visited = mark;
		com.stephengware.java.planware.util.AbstractGraph<T>.NeighborList.Neighbor neighbor = current.neighbors.first;
		while(neighbor != null){
			if(neighbor.node.visited != mark && dfSearchForNode(neighbor.node, mark, goal))
				return true;
			neighbor = neighbor.next;
		}
		return false;
	}
	
	public boolean path(T start, T finish){
		Node startNode = getNode(start);
		if(startNode == null)
			return false;
		Node goalNode = getNode(finish);
		if(goalNode == null)
			return false;
		return path(startNode, goalNode);
	}
	
	protected final boolean path(Node start, Node finish){
		boolean result = dfSearchForNode(start, FIRST_MARK, finish);
		dfMark(start, UNVISITED);
		return result;
	}
}
