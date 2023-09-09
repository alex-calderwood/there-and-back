package com.stephengware.java.planware.util;

import java.util.LinkedList;

public class StringWriter extends java.io.Writer {

	private final LinkedList<String> parts = new LinkedList<String>();
	private int length = 0;

	@Override
	public final void write(char[] cbuf, int off, int len){
		char[] part = new char[len];
		System.arraycopy(cbuf, off, part, 0, len);
		parts.add(new String(part));
		length += len;
	}
	
	@Override
	public final void write(String string){
		parts.add(string);
		length += string.length();
	}

	@Override
	public final void flush(){}
	
	@Override
	public final void close(){}
	
	@Override
	public final String toString(){
		char[] all = new char[length];
		int written = 0;
		for(String part : parts){
			part.getChars(0, part.length(), all, written);
			written += part.length();
		}
		return new String(all);
	}
}
