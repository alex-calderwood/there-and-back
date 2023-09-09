package com.stephengware.java.planware.graph;

import java.util.Iterator;

import com.stephengware.java.planware.logic.Literal;

public class LiteralNode extends Node {

	public final Literal literal;
	public final NodeList<EffectNode> parents = new NodeList<>();
	public final NodeList<PreconditionNode> children = new NodeList<>();
	LiteralNode negation = null;
	
	protected LiteralNode(ProblemGraph graph, Literal literal){
		super(graph);
		this.literal = literal;
	}
	
	public LiteralNode getNegation(){
		return negation;
	}
		
	@Override
	public boolean activate(){
		if(super.activate()){
			if(getNegation() != null)
				getNegation().deactivate();
			for(int i=0; i<children.size(); i++)
				children.get(i).incrementParentCount();
			return true;
		}
		return false;
	}
	
	@Override
	public boolean deactivate(){
		if(super.deactivate()){
			LiteralNode negation = getNegation();
			if(negation != null)
				negation.activate();
			for(int i=0; i<children.size(); i++)
				children.get(i).decrementParentCount();
			return true;
		}
		return false;
	}
	
	@Override
	public Iterator<EffectNode> parents(){
		return parents.iterator();
	}
	
	@Override
	public String toString(){
		return "[Literal Node: " + literal + "]";
	}
}
