package com.stephengware.java.planware.io.pddl.sexp;

import java.io.IOException;
import java.io.Writer;
import java.util.Stack;

public class IndentWriter extends Writer {

	private class Level {
		
		public int start = 0;
		public int indent = 0;
		public boolean locked = false;
		
		public Level(int start){
			this.start = start;
		}
	}
	
	protected final Writer writer;
	protected int column = 0;
	protected final Stack<Level> levels;
	private Level currentLevel;
	
	public IndentWriter(Writer writer){
		this.writer = writer;
		this.levels = new Stack<Level>();
		currentLevel = new Level(0);
		currentLevel.locked = true;
		levels.push(currentLevel);
	}
	
	public void setIndent(int indent){
		currentLevel.indent = indent;
		currentLevel.locked = true;
	}
	
	@Override
	public Writer append(char c) throws IOException {
		int increase = 1;
		if(c == '\t'){
			writer.append("    ");
			increase = 4;
		}
		else{
			writer.append(c);
			increase = 1;
		}
		column += increase;
		// Increase indent and possibly lock.
		if(!currentLevel.locked){
			currentLevel.indent += increase;
			if(c == '(' || c == ')' || Character.isWhitespace(c))
				currentLevel.locked = true;
		}
		// Handle special characters.
		if(c == '('){
			currentLevel = new Level(column);
			levels.push(currentLevel);
		}
		else if(c == ')'){
			levels.pop();
			currentLevel = levels.peek();
		}
		else if(c == '\n'){
			int indent = currentLevel.start + currentLevel.indent;
			for(int i=0; i<indent; i++)
				writer.append(' ');
			column = indent;
		}
		return this;
	}
	
	@Override
	public void write(char[] cbuf, int off, int len) throws IOException {
		for(int i=off; i<len; i++)
			append(cbuf[i]);
	}
	
	@Override
	public void flush() throws IOException {
		writer.flush();
	}
	
	@Override
	public void close() throws IOException {
		writer.close();
	}
}
