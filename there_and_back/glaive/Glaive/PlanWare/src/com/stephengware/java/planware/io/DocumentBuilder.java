package com.stephengware.java.planware.io;

public interface DocumentBuilder<T, D> {

	public D build(T object, D document, Builder<D> builder) throws BuildException;
}
