package com.stephengware.java.planware.ig;

import java.util.HashMap;
import java.util.Iterator;

import com.stephengware.java.planware.CausalPath;
import com.stephengware.java.planware.graph.EffectNode;
import com.stephengware.java.planware.graph.Node;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.pg.LiteralNode;

class GoalTree {

	public final Constant agent;
	public final GoalNode goal;
	public final StepNode[] steps;
	public final int[] distances;
	
	private GoalTree(Constant agent, GoalNode goal, StepNode[] steps, int[] distances){
		this.agent = agent;
		this.goal = goal;
		this.steps = steps;
		this.distances = distances;
	}
	
	static final GoalTree makeGoalTree(Constant agent, GoalNode goal){
		HashMap<StepNode, Integer> stepDistances = new HashMap<>();
		collectCausalAncestors(agent, goal, 0, CausalPath.EMPTY, stepDistances);
		StepNode[] steps = stepDistances.keySet().toArray(new StepNode[stepDistances.size()]);
		int[] distances = new int[steps.length];
		for(int i=0; i<steps.length; i++)
			distances[i] = stepDistances.get(steps[i]);
		return new GoalTree(agent, goal, steps, distances);
	}

	private static final void collectCausalAncestors(Constant agent, Node node, int distance, CausalPath path, HashMap<StepNode, Integer> steps){
		Integer d = steps.get(node);
		if(d == null || distance < d){
			if(node instanceof LiteralNode){
				Literal literal = ((LiteralNode) node).literal;
				if(path.contains(literal))
					return;
				else
					path = path.add(literal);
			}
			else if(node instanceof StepNode){
				StepNode stepNode = (StepNode) node;
				for(EffectNode effect : stepNode.children)
					if(path.rest.contains(effect.child.literal))
						return;
				if(stepNode.step.agents.contains(agent)){
					steps.put(stepNode, distance);
					distance++;
				}
				else
					return;
			}
			for(Iterator<? extends Node> parents = node.parents(); parents.hasNext();)
				collectCausalAncestors(agent, parents.next(), distance, path, steps);
		}
	}
	
	final void motivate(){
		for(int i=0; i<steps.length; i++)
			steps[i].motivate(agent);
	}
}
