package com.stephengware.java.planware.pg;

import java.util.Arrays;

class NextStepNodeList {
	
	private static final int INITIAL_CAPACITY = 128;
	
	private StepNode[] array = new StepNode[INITIAL_CAPACITY];
	private int size = 0;
	
	void add(StepNode stepNode){
		if(size == array.length)
			array = Arrays.copyOf(array, array.length * 2);
		array[size] = stepNode;
		size++;
	}
	
	boolean isEmpty(){
		return size == 0;
	}
	
	void clear(){
		size = 0;
	}
	
	void activateAll(){
		activateAll(0);
	}
	
	private final void activateAll(int index){
		if(index == size)
			clear();
		else{
			StepNode stepNode = array[index];
			activateAll(index + 1);
			stepNode.activate();
		}
	}
}
