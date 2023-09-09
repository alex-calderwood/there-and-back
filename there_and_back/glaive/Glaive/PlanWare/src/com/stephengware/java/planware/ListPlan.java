package com.stephengware.java.planware;

import java.util.LinkedList;

public class ListPlan extends Plan {

	private final class Node {
		
		public final Step step;
		public final Node next;
		
		public Node(Step step, Node next){
			this.step = step;
			this.next = next;
		}
	}
	
	private Node first;
	private int size;
	
	protected ListPlan(ListPlan plan){
		super(plan.name, plan.problem);
		this.first = plan.first;
		this.size = plan.size;
	}
	
	public ListPlan(String name, Problem problem){
		super(name, problem);
		this.first = null;
		this.size = 0;
	}
	
	@Override
	public int countSteps(){
		return size;
	}

	@Override
	public Iterable<? extends Step> steps(){
		LinkedList<Step> steps = new LinkedList<>();
		Node node = first;
		while(node != null){
			steps.add(0, node.step);
			node = node.next;
		}
		return steps;
	}

	public void addStep(Step step){
		this.first = new Node(step, first);
		size++;
	}

	@Override
	public ListPlan clone(){
		return new ListPlan(this);
	}
}
