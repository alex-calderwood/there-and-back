package com.stephengware.java.planware.io;

import java.io.IOException;
import java.io.Reader;

public interface DocumentReader<D> {

	public D read(Reader reader) throws IOException, ParseException;
	
	public int getLineNumber(D document);
	
	public int getCharacterNumber(D document);
}
