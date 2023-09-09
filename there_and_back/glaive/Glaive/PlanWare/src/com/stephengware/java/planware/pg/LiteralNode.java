package com.stephengware.java.planware.pg;

import com.stephengware.java.planware.logic.Literal;

public class LiteralNode extends com.stephengware.java.planware.graph.LiteralNode {

	protected final PlanGraph graph;
	private int level = -1;
	
	protected LiteralNode(PlanGraph graph, Literal literal){
		super(graph, literal);
		this.graph = graph;
	}
	
	@Override
	public boolean activate(){
		if(super.activate()){
			level = graph.countLevels() - 1;
			graph.levels.addLiteral(this);
			return true;
		}
		return false;
	}
	
	@Override
	public boolean deactivate(){
		return false;
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
