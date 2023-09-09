package com.stephengware.java.planware.io;

import java.io.IOException;
import java.io.Writer;

public interface DocumentWriter<D> {

	public void write(D document, Writer writer) throws IOException, BuildException;
}
