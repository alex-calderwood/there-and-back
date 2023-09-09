package com.stephengware.java.planware.util;

public class DirectedGraph<T> extends AbstractGraph<T> {

	protected class DirectedNode extends Node {

		public final NeighborList parents = new NeighborList();
		
		public DirectedNode(T content){
			super(content);
		}
	}
	
	protected final Hashtable<T, DirectedNode> nodes = new Hashtable<T, DirectedNode>();
	private int edgeCount = 0;
	
	@Override
	protected final DirectedNode getNode(T element){
		return nodes.get(element);
	}
	
	protected final DirectedNode getOrMakeNode(T element){
		DirectedNode node = getNode(element);
		if(node == null){
			node = new DirectedNode(element);
			nodes.put(element, node);
		}
		return node;
	}

	@Override
	public void addNode(T content){
		getOrMakeNode(content);
	}

	@Override
	public void removeNode(T content){
		DirectedNode node = getNode(content);
		if(node == null)
			return;
		nodes.remove(content);
		com.stephengware.java.planware.util.AbstractGraph<T>.NeighborList.Neighbor neighbor = node.parents.first;
		while(neighbor != null){
			neighbor.node.neighbors.remove(node);
			neighbor = neighbor.next;
		}
	}
	
	@Override
	public int countNodes(){
		return nodes.size();
	}

	@Override
	public Iterable<T> nodes(){
		return nodes.keys();
	}
	
	@Override
	public int countEdges(){
		return edgeCount;
	}

	@Override
	public void addEdge(T tail, T head){
		DirectedNode tailNode = getOrMakeNode(tail);
		DirectedNode headNode = getOrMakeNode(head);
		tailNode.neighbors.link(headNode);
		headNode.parents.link(tailNode);
		edgeCount++;
	}

	@Override
	public void removeEdge(T tail, T head){
		DirectedNode tailNode = getNode(tail);
		if(tailNode == null)
			return;
		DirectedNode headNode = getNode(head);
		if(headNode == null)
			return;
		tailNode.neighbors.unlink(headNode);
		headNode.parents.unlink(tailNode);
		edgeCount--;
	}

	@Override
	public Iterable<Edge<T>> edges(){
		List<Edge<T>> edges = new List<Edge<T>>();
		for(Node tail : nodes.values())
			for(Node head : tail.neighbors)
				edges.add(new Edge<T>(tail.content, head.content));
		return edges;
	}
	
	public boolean haveCommonDescendant(T first, T second){
		Node firstNode = getNode(first);
		if(firstNode == null)
			return false;
		Node secondNode = getNode(second);
		if(secondNode == null)
			return false;
		return haveCommonDescendant(firstNode, secondNode);
	}
	
	protected final boolean haveCommonDescendant(Node first, Node second){
		dfMark(first, FIRST_MARK);
		boolean result = dfSearchForMark(second, SECOND_MARK, FIRST_MARK);
		dfMark(first, UNVISITED);
		dfMark(second, UNVISITED);
		return result;
	}
	
	public Iterable<T> getDescendants(T parent){
		List<T> descendants = new List<T>();
		Node parentNode = getNode(parent);
		dfMarkCollect(parentNode, FIRST_MARK, descendants);
		dfMark(parentNode, UNVISITED);
		descendants.remove(parent);
		return descendants;
	}
	
	protected final void dfMarkCollect(Node current, int mark, List<T> collection){
		current.visited = mark;
		collection.add(current.content);
		com.stephengware.java.planware.util.AbstractGraph<T>.NeighborList.Neighbor neighbor = current.neighbors.first;
		while(neighbor != null){
			if(neighbor.node.visited != mark)
				dfMarkCollect(neighbor.node, mark, collection);
			neighbor = neighbor.next;
		}
	}

	@Override
	public Object clone(){
		DirectedGraph<T> clone = new DirectedGraph<>();
		for(T node : nodes())
			clone.addNode(node);
		for(Edge<T> edge : edges())
			clone.addEdge(edge.tail, edge.head);
		return clone;
	}
}
