package com.stephengware.java.planware.io;

public interface Extension<I, O> {

	public void configure(Parser<I> parser);
	
	public void configure(Builder<O> builder);
}
