package com.stephengware.java.glaive;

import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.util.ImmutableArray;

public class ExpressionEvent extends Event {

	private static final ImmutableArray<CausalLink> NO_IN_LINKS = new ImmutableArray<>(new CausalLink[0]);
	
	protected ExpressionEvent(Expression expression, int time){
		super(expression, time, NO_IN_LINKS);
	}

}
