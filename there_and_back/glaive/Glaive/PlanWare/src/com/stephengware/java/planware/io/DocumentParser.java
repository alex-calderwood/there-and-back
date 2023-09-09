package com.stephengware.java.planware.io;

public abstract class DocumentParser<D> {
	
	public abstract void parse(D document, Parser<D> parser) throws ParseException;
	
	protected final void succeed(Object object){
		throw new SuccessAction(object);
	}
	
	protected final void fail(){
		throw new FailureAction();
	}
}
