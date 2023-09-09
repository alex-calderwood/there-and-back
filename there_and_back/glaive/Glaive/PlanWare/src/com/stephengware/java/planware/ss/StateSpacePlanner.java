package com.stephengware.java.planware.ss;

import com.stephengware.java.planware.Argument;
import com.stephengware.java.planware.ArgumentMap;
import com.stephengware.java.planware.AxiomTree;
import com.stephengware.java.planware.Planner;
import com.stephengware.java.planware.Problem;

public abstract class StateSpacePlanner<P extends Problem> extends Planner<P> {

	public static final Argument<StateSpace> STATE_SPACE = new Argument.ParsedArgument<StateSpace>("state_space", "ss", StateSpace.class){
		
		@Override
		protected StateSpace getValue(Object object, ArgumentMap arguments){
			if(object == null){
				StateSpace space = new StateSpace(arguments.get(PROBLEM));
				arguments.set(this, space);
				return space;
			}
			else
				return super.getValue(object, arguments);
		}
	};
	
	public static final Argument<AxiomTree> AXIOM_TREE = new Argument<AxiomTree>("axiom_tree"){

		@Override
		protected AxiomTree getValue(Object object, ArgumentMap arguments){
			if(object instanceof AxiomTree)
				return (AxiomTree) object;
			else{
				StateSpace space = arguments.get(STATE_SPACE);
				AxiomTree tree = new AxiomTree(space.axioms);
				arguments.set(this, tree);
				return tree;
			}
		}
	};
	
	public StateSpacePlanner(String name){
		super(name);
	}
}
