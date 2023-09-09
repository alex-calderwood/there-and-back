package com.stephengware.java.planware.io.pddl.sexp;

import java.io.IOException;
import java.io.Writer;

import com.stephengware.java.planware.io.BuildException;

public class DocumentWriter implements com.stephengware.java.planware.io.DocumentWriter<SExpression> {

	public static final com.stephengware.java.planware.io.DocumentWriter<SExpression> DOCUMENT_WRITER = new DocumentWriter();
	
	@Override
	public void write(SExpression document, Writer writer) throws IOException, BuildException {
		document.write(writer);
	}
}
