package com.stephengware.java.glaive;

import java.util.Arrays;
import java.util.Iterator;
import java.util.NoSuchElementException;

import com.stephengware.java.planware.util.CountableIterable;

public class TokenList implements CountableIterable<Token> {

	private final Token[] tokens;
	
	protected TokenList(Token[] tokens){
		this.tokens = tokens;
	}
	
	public TokenList(int capacity){
		this(new Token[capacity]);
	}
	
	public void add(Token token){
		int index = 0;
		int shift = 0;
		while(index < tokens.length){
			if(tokens[index] == null)
				break;
			// Remove tokens which are no longer orphans.
			if(!tokens[index].stepEvent.isOrphan()){
				tokens[index] = null;
				shift++;
			}
			// Remove tokens which are for the same goal.
			else if(token.goal == tokens[index].goal){
				tokens[index] = null;
				shift++;
			}
			// Replace tokens which can be advanced.
			else if(advances(token, tokens[index])){
				tokens[index] = null;
				shift++;
			}
			// Shift tokens to replace missing ones.
			if(shift != 0 && tokens[index] != null){
				tokens[index - shift] = tokens[index];
				tokens[index] = null;
			}
			index++;
		}
		if(token.stepEvent.isOrphan(token.agent))
			tokens[index - shift] = token;
	}
	
	private static final boolean advances(Token after, Token before){
		if(!before.agent.equals(after.agent))
			return false;
		for(int j=0; j<after.stepEvent.inLinks.length; j++)
			if(findAncestor(after.stepEvent.inLinks.get(j).tail, before.stepEvent))
				return true;
		return false;
	}
	
	private static final boolean findAncestor(Event event, StepEvent target){
		if(event == target)
			return true;
		else if(event instanceof StepEvent)
			return false;
		else{
			for(int i=0; i<event.inLinks.length; i++)
				if(findAncestor(event.inLinks.get(i).tail, target))
					return true;
			return false;
		}
	}
	
	private final class MyIterator implements Iterator<Token> {

		private int index = 0;
		
		@Override
		public boolean hasNext(){
			return index < tokens.length && tokens[index] != null;
		}

		@Override
		public Token next(){
			if(!hasNext())
				throw new NoSuchElementException("There are no more tokens.");
			Token token = tokens[index];
			index++;
			return token;
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}
	
	@Override
	public Iterator<Token> iterator(){
		return new MyIterator();
	}

	@Override
	public int size(){
		int size = 0;
		while(size < tokens.length && tokens[size] != null)
			size++;
		return size;
	}
	
	public int countDistances(){
		int total = 0;
		for(Token token : tokens){
			if(token != null){
				if(token.distance == 0)
					total += 1;
				else
					total += token.distance;
			}
		}
		return total;
	}
	
	public TokenList clone(int newSpace){
		int newLength = tokens.length + newSpace;
		for(int i=tokens.length-1; i>=0; i--){
			if(tokens[i] == null)
				newLength--;
			else
				break;
		}
		return new TokenList(Arrays.copyOf(tokens, newLength));
	}
	
	@Override
	public String toString(){
		String str = "TOKENS:";
		for(int i=0; i<tokens.length; i++)
			if(tokens[i] != null)
				str += "\n  " + tokens[i];
		return str;
	}
}
