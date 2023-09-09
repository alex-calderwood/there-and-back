package com.stephengware.java.planware.graph;

import java.util.Iterator;

import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.util.ArrayIterator;

public class EffectNode extends SatisfiableNode {

	public final Expression effect;
	public final ChangeNode parent;
	public final LiteralNode child;
	
	protected EffectNode(ProblemGraph graph, ChangeNode parent, Expression effect, LiteralNode child){
		super(graph);
		this.effect = effect;
		this.parent = parent;
		this.child = child;
	}
		
	@Override
	public boolean activate(){
		if(super.activate()){
			child.activate();
			return true;
		}
		return false;
	}
	
	@Override
	public Iterator<ChangeNode> parents(){
		return new ArrayIterator<>(new ChangeNode[]{parent});
	}
	
	@Override
	public String toString(){
		return "[Effect Node: " + effect + "]";
	}
}
