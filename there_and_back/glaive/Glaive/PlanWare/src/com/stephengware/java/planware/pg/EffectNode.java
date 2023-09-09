package com.stephengware.java.planware.pg;

import com.stephengware.java.planware.graph.ChangeNode;
import com.stephengware.java.planware.graph.LiteralNode;
import com.stephengware.java.planware.logic.Expression;

public class EffectNode extends com.stephengware.java.planware.graph.EffectNode {

	private final PlanGraph graph;
	private int level = -1;
	
	protected EffectNode(PlanGraph graph, ChangeNode parent, Expression effect, LiteralNode child){
		super(graph, parent, effect, child);
		this.graph = graph;
	}
	
	@Override
	public boolean activate(){
		if(super.activate()){
			level = graph.countLevels() - 1;
			return true;
		}
		return false;
	}
	
	@Override
	public void satisfy(){
		super.satisfy();
		if(parent.isActive())
			activate();
	}
	
	@Override
	public void reset(){
		super.reset();
		level = -1;
	}
	
	public int getLevel(){
		return level;
	}
}
