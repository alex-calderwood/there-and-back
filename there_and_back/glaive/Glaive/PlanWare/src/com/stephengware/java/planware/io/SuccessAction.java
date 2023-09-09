package com.stephengware.java.planware.io;

class SuccessAction extends RuntimeException {

	private static final long serialVersionUID = 1L;
	public final Object object;
	
	public SuccessAction(Object object){
		this.object = object;
	}
}
