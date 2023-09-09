package com.stephengware.java.planware.util;

public class Graph<T> extends AbstractGraph<T> {

	protected final Hashtable<T, Node> nodes = new Hashtable<T, Node>();
	private int edgeCount = 0;
	
	@Override
	protected final Node getNode(T element){
		return nodes.get(element);
	}
	
	protected final Node getOrMakeNode(T element){
		Node node = getNode(element);
		if(node == null){
			node = new Node(element);
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
		Node node = getNode(content);
		if(node == null)
			return;
		nodes.remove(content);
		NeighborList.Neighbor neighbor = node.neighbors.first;
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
	public int countEdges() {
		return edgeCount;
	}

	@Override
	public void addEdge(T tail, T head){
		Node tailNode = getOrMakeNode(tail);
		Node headNode = getOrMakeNode(head);
		tailNode.neighbors.link(headNode);
		headNode.neighbors.link(tailNode);
		edgeCount++;
	}

	@Override
	public void removeEdge(T tail, T head){
		Node tailNode = getNode(tail);
		if(tailNode == null)
			return;
		Node headNode = getNode(head);
		if(headNode == null)
			return;
		tailNode.neighbors.unlink(headNode);
		headNode.neighbors.unlink(tailNode);
		edgeCount--;
	}

	@Override
	public Iterable<Edge<T>> edges(){
		List<Edge<T>> edges = new List<Edge<T>>();
		for(Node tail : nodes.values())
			for(Node head : tail.neighbors)
				if(tail.hashCode() <= head.hashCode())
					edges.add(new Edge<T>(tail.content, head.content));
		return edges;
	}

	@Override
	public Object clone(){
		Graph<T> clone = new Graph<>();
		for(T node : nodes())
			clone.addNode(node);
		for(Edge<T> edge : edges())
			clone.addEdge(edge.tail, edge.head);
		return clone;
	}
}
