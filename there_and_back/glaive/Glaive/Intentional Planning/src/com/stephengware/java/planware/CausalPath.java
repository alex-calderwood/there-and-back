package com.stephengware.java.planware;

import com.stephengware.java.planware.logic.Literal;

public class CausalPath {

	public static final CausalPath EMPTY = new CausalPath(null, null);
	
	public final Literal literal;
	public final CausalPath rest;
	
	private CausalPath(Literal literal, CausalPath rest){
		this.literal = literal;
		this.rest = rest;
	}
	
	public final boolean contains(Literal literal){
		CausalPath node = this;
		while(node.literal != null){
			if(node.literal.equals(literal) || node.literal.equals(literal.negate()))
				return true;
			node = node.rest;
		}
		return false;
	}
	
	public CausalPath add(Literal literal){
		return new CausalPath(literal, this);
	}
}
