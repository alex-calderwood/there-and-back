package com.stephengware.java.planware.ss;

import com.stephengware.java.planware.Argument;
import com.stephengware.java.planware.ArgumentMap;
import com.stephengware.java.planware.AxiomTree;
import com.stephengware.java.planware.IntentionalDomain;
import com.stephengware.java.planware.IntentionalPlanner;
import com.stephengware.java.planware.IntentionalProblem;

public abstract class IntentionalStateSpacePlanner<P extends IntentionalProblem> extends StateSpacePlanner<P> {
	
	public static final Argument<IntentionalDomain> DOMAIN = IntentionalPlanner.DOMAIN;
	
	public static final Argument<IntentionalProblem> PROBLEM = IntentionalPlanner.PROBLEM;
	
	public static final Argument<IntentionalStateSpace> STATE_SPACE = new Argument.ParsedArgument<IntentionalStateSpace>(StateSpacePlanner.STATE_SPACE.name, StateSpacePlanner.STATE_SPACE.abbreviation, IntentionalStateSpace.class){
		
		@Override
		protected IntentionalStateSpace getValue(Object object, ArgumentMap arguments){
			if(object == null){
				IntentionalStateSpace space = new IntentionalStateSpace(arguments.get(PROBLEM));
				arguments.set(this, space);
				return space;
			}
			else
				return super.getValue(object, arguments);
		}
	};
	
	public static final Argument<AxiomTree> AXIOM_TREE = new Argument<AxiomTree>(StateSpacePlanner.AXIOM_TREE.name){

		@Override
		protected AxiomTree getValue(Object object, ArgumentMap arguments){
			if(object instanceof AxiomTree)
				return (AxiomTree) object;
			else{
				IntentionalStateSpace space = arguments.get(STATE_SPACE);
				AxiomTree tree = new AxiomTree(space.axioms);
				arguments.set(this, tree);
				return tree;
			}
		}
	};
	
	public IntentionalStateSpacePlanner(String name){
		super(name);
	}
}
