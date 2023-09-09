package com.stephengware.java.planware.util;

import java.util.HashSet;
import java.util.LinkedList;

public class DirectedAcyclicGraph<T> extends DirectedGraph<T> {

	@Override
	public void addEdge(T tail, T head){
		if(tail == head)
			throw new CycleException(tail, head);
		DirectedNode tailNode = getOrMakeNode(tail);
		DirectedNode headNode = getOrMakeNode(head);
		if(path(headNode, tailNode))
			throw new CycleException(tail, head);
		tailNode.neighbors.link(headNode);
		headNode.parents.link(tailNode);
	}
	
	@Override
	public Object clone(){
		DirectedAcyclicGraph<T> clone = new DirectedAcyclicGraph<>();
		for(T node : nodes())
			clone.addNode(node);
		for(Edge<T> edge : edges())
			clone.addEdge(edge.tail, edge.head);
		return clone;
	}
	
	public java.util.List<T> sort(){
		LinkedList<T> list = new LinkedList<>();
		HashSet<DirectedNode> mark = new HashSet<>();
		for(DirectedNode node : nodes.values())
			topoSort(node, mark, list);
		return list;
	}
	
	@SuppressWarnings("unchecked")
	private final void topoSort(DirectedNode node, HashSet<DirectedNode> mark, LinkedList<T> list){
		if(mark.contains(node))
			return;
		mark.add(node);
		com.stephengware.java.planware.util.AbstractGraph<T>.NeighborList.Neighbor neighbor = node.neighbors.first;
		while(neighbor != null){
			topoSort((DirectedNode) neighbor.node, mark, list);
			neighbor = neighbor.next;
		}
		list.add(0, node.content);
	}
}
