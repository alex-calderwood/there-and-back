package com.stephengware.java.planware.io.pddl.sexp;

import java.io.IOException;
import java.io.Writer;
import java.util.Iterator;

public abstract class FormatRule {

	public static final FormatRule DEFAULT = new DefaultFormatRule();
	public static final FormatRule EACH_ELEMENT_ON_NEW_LINE = new EachElementOnNewLine();
	public static final FormatRule TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE = new TwoOnFirstLine();
	public static final FormatRule TYPE_AT_END_OF_LINE = new TypeAtEndOfLine();
	public static final FormatRule KEYWORD_ON_NEW_LINE = new KeywordOnNewLine();
	public static final FormatRule PDDL_DOCUMENT = new PDDLDocument();
	
	public abstract void format(Parent list, Writer writer) throws IOException;
	
	private static final IndentWriter wrapInLispWriter(Writer writer){
		if(writer instanceof IndentWriter)
			return (IndentWriter) writer;
		else
			return new IndentWriter(writer);
	}
	
	protected static class DefaultFormatRule extends FormatRule {

		@Override
		public void format(Parent document, Writer writer) throws IOException {
			if(document instanceof List)
				writer.append('(');
			boolean first = true;
			for(Node child : document){
				if(first)
					first = false;
				else
					writer.append(' ');
				child.write(writer);
			}
			if(document instanceof List)
				writer.append(')');
		}
	}
	
	protected static class EachElementOnNewLine extends FormatRule {

		@Override
		public void format(Parent document, Writer writer) throws IOException {
			if(document instanceof List)
				writer.append('(');
			boolean first = true;
			for(Node child : document){
				if(first)
					first = false;
				else
					writer.append('\n');
				child.write(writer);
			}
			if(document instanceof List)
				writer.append(')');
		}
	}
	
	protected static class TwoOnFirstLine extends FormatRule {

		@Override
		public void format(Parent document, Writer writer) throws IOException {
			if(document instanceof List)
				writer.append('(');
			int count = 1;
			for(Node child : document){
				if(count == 2)
					writer.append(' ');
				else if(count > 2)
					writer.append('\n');
				child.write(writer);
				count++;
			}
			if(document instanceof List)
				writer.append(')');
		}
	}
	
	protected static class TypeAtEndOfLine extends FormatRule {

		@Override
		public void format(Parent document, Writer writer) throws IOException {
			writer.append('(');
			boolean first = true;
			boolean newLine = false;
			for(Iterator<Node> iterator = document.iterator(); iterator.hasNext();){
				Node child = iterator.next();
				if(first)
					first = false;
				else if(newLine){
					writer.append('\n');
					newLine = false;
				}
				else
					writer.append(' ');
				child.write(writer);
				if(child.isSymbol("-") && iterator.hasNext()){
					writer.append(' ');
					iterator.next().write(writer);
					newLine = true;
				}
			}
			writer.append(')');
		}
	}
	
	protected static class KeywordOnNewLine extends FormatRule {
		
		@Override
		public void format(Parent document, Writer writer) throws IOException {
			IndentWriter lispWriter = wrapInLispWriter(writer);
			int longestKey = 0;
			for(Node child : document){
				if(child.isSymbol()){
					Symbol symbol = (Symbol) child;
					if(symbol.content.startsWith(":"))
						longestKey = Math.max(longestKey, symbol.content.length());
				}
			}			
			if(document instanceof List)
				lispWriter.append('(');
			boolean first = true;
			for(Node child : document){
				if(first){
					child.write(lispWriter);
					first = false;
				}
				else if(child.isSymbol() && ((Symbol) child).content.startsWith(":")){
					Symbol symbol = (Symbol) child;
					lispWriter.setIndent(1);
					lispWriter.append('\n');
					symbol.write(lispWriter);
					for(int i=symbol.content.length(); i<longestKey; i++)
						lispWriter.append(" ");
				}
				else{
					lispWriter.append(" ");
					child.write(lispWriter);
				}
			}			
			if(document instanceof List)
				lispWriter.append(')');
		}
	}
	
	protected static class PDDLDocument extends FormatRule {

		@Override
		public void format(Parent document, Writer writer) throws IOException {
			IndentWriter lispWriter = wrapInLispWriter(writer);
			if(document instanceof List)
				lispWriter.append('(');
			int count = 1;
			for(Node child : document){
				if(count == 2)
					lispWriter.append(' ');
				else if(count == 3){
					lispWriter.setIndent(1);
					lispWriter.append('\n');
				}
				else if(count > 3)
					lispWriter.append('\n');
				child.write(lispWriter);
				count++;
			}
			if(document instanceof List)
				lispWriter.append(')');	
		}
	}
}
