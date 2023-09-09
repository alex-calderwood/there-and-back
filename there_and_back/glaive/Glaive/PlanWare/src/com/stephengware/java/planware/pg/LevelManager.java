package com.stephengware.java.planware.pg;

import java.util.Arrays;
import java.util.Iterator;

import com.stephengware.java.planware.graph.Node;
import com.stephengware.java.planware.util.ArrayList;

public class LevelManager {
	
	private int currentLevel = -1;
	private ArrayList<LiteralNode>[] literals;
	private ArrayList<StepNode>[] steps;
	
	@SuppressWarnings("unchecked")
	LevelManager(){
		this.literals = (ArrayList<LiteralNode>[]) new ArrayList[0];
		this.steps = (ArrayList<StepNode>[]) new ArrayList[0];
	}
	
	void reset(){
		for(int i=0; i<=currentLevel; i++){
			literals[i].clear();
			steps[i].clear();
		}
		currentLevel = -1;
	}
	
	void incremenetLevel(){
		currentLevel++;
		if(literals.length <= currentLevel){
			literals = Arrays.copyOf(literals, literals.length + 1);
			literals[literals.length - 1] = new ArrayList<>();
			steps = Arrays.copyOf(steps, steps.length + 1);
			steps[steps.length - 1] = new ArrayList<>();
		}
	}
	
	void addLiteral(LiteralNode literalNode){
		literals[currentLevel].add(literalNode);
	}
	
	void addStep(StepNode stepNode){
		steps[currentLevel].add(stepNode);
	}
	
	public int countLevels(){
		return currentLevel + 1;
	}
	
	public int countLiteralsAtLevel(int level){
		checkLevel(level);
		int count = 0;
		for(int i=0; i<=level; i++)
			count += literals[i].size();
		return count;
	}
	
	public int countStepsAtLevel(int level){
		checkLevel(level);
		int count = 0;
		for(int i=0; i<=level; i++)
			count += steps[i].size();
		return count;
	}
	
	private abstract class LevelNodeIterator<N extends Node> implements Iterator<N> {

		private int level;
		private Iterator<N> iterator;
		
		public LevelNodeIterator(int level){
			this.level = level;
			iterator = getNodesAtLevel(level).iterator();
			advance();
		}
		
		private final void advance(){
			while(!iterator.hasNext() && level > 0){
				level--;
				iterator = getNodesAtLevel(level).iterator();
			}
		}
		
		protected abstract Iterable<N> getNodesAtLevel(int level);
		
		@Override
		public boolean hasNext(){
			return iterator.hasNext();
		}

		@Override
		public N next(){
			N node = iterator.next();
			advance();
			return node;
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}
	
	private final class LiteralNodeIterator extends LevelNodeIterator<LiteralNode> {

		public LiteralNodeIterator(int level){
			super(level);
		}

		@Override
		protected Iterable<LiteralNode> getNodesAtLevel(int level){
			return literals[level];
		}
	}
	
	public Iterator<LiteralNode> getLiteralsAtLevel(int level){
		checkLevel(level);
		return new LiteralNodeIterator(level);
	}
	
	private final class StepNodeIterator extends LevelNodeIterator<StepNode> {

		public StepNodeIterator(int level){
			super(level);
		}

		@Override
		protected Iterable<StepNode> getNodesAtLevel(int level){
			return steps[level];
		}
	}
	
	public Iterator<StepNode> getStepsAtLevel(int level){
		checkLevel(level);
		return new StepNodeIterator(level);
	}
	
	private final void checkLevel(int level){
		if(level < 0 || level > currentLevel)
			throw new IndexOutOfBoundsException("The plan graph has only " + (currentLevel + 1) + " levels.");
	}
}
