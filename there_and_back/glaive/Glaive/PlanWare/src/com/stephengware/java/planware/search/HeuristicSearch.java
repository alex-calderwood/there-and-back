package com.stephengware.java.planware.search;

import java.util.Comparator;
import java.util.PriorityQueue;

public class HeuristicSearch<N extends Node> implements Strategy<N> {

	protected final class HeuristicNode {
		
		public final N node;
		public final double hValue;
		
		private HeuristicNode(N node, double hvalue){
			this.node = node;
			this.hValue = hvalue;
		}
	}
	
	private final Comparator<HeuristicNode> LOWEST_FIRST = new Comparator<HeuristicNode>(){

		@Override
		public int compare(HeuristicNode node1, HeuristicNode node2){
			double difference = node1.hValue - node2.hValue;
			if(difference == 0)
				difference = node2.node.getPlan().countSteps() - node1.node.getPlan().countSteps();
			if(difference == 0)
				difference = tieBreaker.compare(node1.node, node2.node);
			if(difference == 0)
				return node1.node.id - node2.node.id;
			else if(difference > 0)
				return 1;
			else
				return -1;
		}
	};
	
	public final Heuristic<? super N> heuristic;
	public final Comparator<? super N> tieBreaker;
	private final PriorityQueue<HeuristicNode> queue;
	private HeuristicNode bestNode = null;
	private final boolean debug;
	
	public HeuristicSearch(Heuristic<? super N> heuristic, Comparator<? super N> tieBreaker, N root, boolean debug){
		this.heuristic = heuristic;
		this.tieBreaker = tieBreaker;
		this.debug = debug;
		this.queue = new PriorityQueue<HeuristicNode>(10000, LOWEST_FIRST);
		push(root);
	}
	
	public HeuristicSearch(Heuristic<? super N> heuristic, N root, boolean debug){
		this(heuristic, new Comparator<N>(){
			@Override
			public int compare(N node1, N node2) {
				return 0;
			}
		}, root, false);
	}
	
	protected HeuristicNode peek(){
		if(queue.isEmpty())
			return null;
		HeuristicNode hnode = queue.peek();
		if(bestNode == null || hnode.hValue <= bestNode.hValue)
			bestNode = hnode;
		return hnode;
	}
	
	public N next(NodeSearch<N> search){
		HeuristicNode hnode = pop();
		if(hnode == null)
			return null;
		else
			return hnode.node;
	}

	protected HeuristicNode pop(){
		if(queue.isEmpty())
			return null;
		HeuristicNode hnode = queue.poll();
		if(bestNode == null || hnode.hValue <= bestNode.hValue)
			bestNode = hnode;
		if(debug)
			System.out.println("----------\n" + hnode.node + "\n  heuristic = " + hnode.hValue);
		return hnode;
	}

	@Override
	public int expand(NodeSearch<N> search, N node){
		int generated = 0;
		while(search.hasNextSuccessor(node)){
			push(search.getNextSuccessor(node));
			generated++;
		}
		return generated;
	}
	
	protected HeuristicNode push(N node){
		HeuristicNode hnode = new HeuristicNode(node, heuristic.getValue(node));
		if(hnode.hValue != Heuristic.INFINITE)
			queue.add(hnode);
		return hnode;
	}
	
	public N getBestNode(){
		if(bestNode == null)
			return null;
		else
			return bestNode.node;
	}
}
