package com.stephengware.java.planware.io;

public abstract class SimpleExtension<D, T> extends DocumentParser<D> implements Extension<D, D>, DocumentBuilder<T, D> {
	
	public final Class<T> objectType;
	private final boolean overrides;
	
	public SimpleExtension(Class<T> objectType, boolean overrides){
		this.objectType = objectType;
		this.overrides = overrides;
	}
	
	public SimpleExtension(Class<T> objectType){
		this(objectType, false);
	}	
	
	@Override
	public void configure(Parser<D> parser){
		if(overrides)
			parser.overrideDocumentParser(objectType, this);
		else
			parser.addDocumentParser(objectType, this);
	}
	
	@Override
	public void configure(Builder<D> builder){
		if(overrides)
			builder.overrideDocumentBuilder(objectType, this);
		else
			builder.addDocumentBuilder(objectType, this);
	}
}
