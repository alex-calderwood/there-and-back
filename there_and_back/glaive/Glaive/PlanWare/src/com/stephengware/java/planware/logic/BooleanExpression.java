package com.stephengware.java.planware.logic;

import java.util.Iterator;

public abstract class BooleanExpression extends ExpressionObject {
		
	public final String operator;
	
	protected BooleanExpression(String operator){
		this.operator = operator.intern();
	}
	
	@Override
	public abstract Iterator<? extends Expression> iterator();
	
	@Override
	public String getDescription(){
		return "boolean expression";
	}
}