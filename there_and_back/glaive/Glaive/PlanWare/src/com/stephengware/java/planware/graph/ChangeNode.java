package com.stephengware.java.planware.graph;

import java.util.Iterator;
import java.util.NoSuchElementException;

public abstract class ChangeNode extends SatisfiableNode {
	
	public final NodeList<EffectNode> children = new NodeList<>();

	protected ChangeNode(ProblemGraph graph){
		super(graph);
	}
	
	@Override
	public boolean activate(){
		if(super.activate()){
			for(int i=0; i<children.size(); i++){
				EffectNode effect = children.get(i);
				if(effect.isSatisfied())
					effect.activate();
			}
			return true;
		}
		return false;
	}
	
	@Override
	public boolean deactivate(){
		if(super.deactivate()){
			for(int i=0; i<children.size(); i++)
				children.get(i).deactivate();	
			return true;
		}
		return false;
	}
	
	@Override
	public void dissatisfy(){
		super.dissatisfy();
		deactivate();
	}
	
	private final class ParentIterator implements Iterator<PreconditionNode> {

		private Iterator<PreconditionNode> parentIterator = ChangeNode.this.parents.iterator();
		private Iterator<EffectNode> childIterator = children.iterator();
		
		public ParentIterator(){
			advance();
		}
		
		private final void advance(){
			while(!parentIterator.hasNext()){
				if(childIterator.hasNext())
					parentIterator = childIterator.next().parents.iterator();
				else
					return;
			}
		}
		
		@Override
		public boolean hasNext(){
			return parentIterator.hasNext();
		}

		@Override
		public PreconditionNode next(){
			if(parentIterator.hasNext()){
				PreconditionNode next = parentIterator.next();
				advance();
				return next;
			}
			else
				throw new NoSuchElementException("There are no more parent nodes.");
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove not supported.");
		}
	}
	
	@Override
	public Iterator<PreconditionNode> parents(){
		return new ParentIterator();
	}
	
	@Override
	public String describe(){
		String str = super.describe();
		for(EffectNode child : children)
			str += "\n  " + child.describe();
		return str;
	}
}
