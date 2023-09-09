package com.stephengware.java.planware.io.pddl.sexp;

import java.util.Iterator;
import java.util.LinkedList;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.ParseException;

class NodeList implements Iterable<Node> {

	private final Parent self;
	private final java.util.List<Node> nodes;
	
	NodeList(Parent self, java.util.List<Node> nodes) throws BuildException {
		this.self = self;
		this.nodes = nodes;
		int index = 1;
		Node previous = null;
		for(Node node : nodes){
			if(node == null)
				throw new BuildException("Child " + index + " cannot be null.");
			index++;
			if(node.getParent() != null)
				node.getParent().removeChild(node);
			node.parent = self;
			node.previous = previous;
			if(previous != null)
				previous.next = node;
			previous = node;
		}
	}
	
	@Override
	public Iterator<Node> iterator(){
		return nodes.iterator();
	}
	
	private final Iterable<Node> REST = new Iterable<Node>(){

		@Override
		public Iterator<Node> iterator(){
			Iterator<Node> iterator = nodes.iterator();
			if(getLength() > 0)
				iterator.next();
			return iterator;
		}		
	};
	
	public Iterable<Node> rest(){
		return REST;
	}
	
	public int getLength(){
		return nodes.size();
	}
	
	public Node getChild(int index) throws ParseException {
		if(index >= nodes.size())
			throw new ParseException(self, "Expected at least " + (index + 1) + " children, but encountered " + nodes.size() + ".");
		return nodes.get(index);
	}
	
	public int indexOf(Node child){
		int index = 0;
		for(Node node : nodes){
			if(node == child)
				return index;
			index++;
		}
		return -1;
	}
	
	public int indexOf(String symbol){
		Symbol s = findSymbol(symbol);
		if(s == null)
			return -1;
		else
			return indexOf(s);
	}
	
	public void addChild(SExpression child) throws BuildException {
		addChild(getLength(), child);
	}
	
	public void addChild(String symbol) throws BuildException {
		addChild(new Symbol(symbol));
	}
	
	public void addChild(int index, SExpression child) throws BuildException {
		if(child == null)
			throw new BuildException("Child cannot be null.");
		if(index < 0)
			throw new BuildException("Cannot add a child at position " + index + ".");
		if(index > nodes.size())
			throw new BuildException("Cannot add a child at position " + index + "; there are only " + nodes.size() + " children.");
		if(child instanceof Node)
			doAddChild(index, (Node) child);
		else{
			LinkedList<Node> rootChildren = new LinkedList<Node>();
			for(Iterator<Node> iterator = ((Root) child).iterator(); iterator.hasNext();)
				rootChildren.add(iterator.next());
			for(Node rootChild : rootChildren){
				doAddChild(index, rootChild);
				index++;
			}
		}
	}
	
	private final void doAddChild(int index, Node child) throws BuildException {
		nodes.add(index, child);
		// Set parent.
		if(child.parent != null)
			child.parent.removeChild(child);
		child.parent = self;
		// Set next sibling.
		Node next = null;
		if(index != getLength() - 1)
			next = nodes.get(index + 1);
		child.next = next;
		if(next != null)
			next.previous = child;
		// Set previous sibling.
		Node previous = null;
		if(index != 0)
			previous = nodes.get(index - 1);
		child.previous = previous;
		if(previous != null)
			previous.next = child;
	}
	
	public void addChild(int index, String symbol) throws BuildException {
		addChild(index, new Symbol(symbol));
	}
	
	public void removeChild(Node child) throws BuildException {
		if(child == null || indexOf(child) == -1)
			throw new BuildException("The node \"" + child + "\" cannot be removed because it is not a child.");
		removeChild(indexOf(child));
	}
	
	public void removeChild(String symbol) throws BuildException {
		removeChild(findSymbol(symbol));
	}
	
	public void removeChild(int index) throws BuildException {
		if(index < 0)
			throw new BuildException("Cannot remove a child at position " + index + ".");
		if(index >= nodes.size())
			throw new BuildException("Cannot remove a child at position " + index + "; there are only " + nodes.size() + " children.");
		Node child = nodes.get(index);
		if(child.previous != null)
			child.previous.next = child.next;
		if(child.next != null)
			child.next.previous = child.previous;
		child.parent = null;
		child.previous = null;
		child.next = null;
		nodes.remove(child);	
	}
	
	public void replaceChild(Node toReplace, Node replacement) throws BuildException {
		replaceChild(indexOf(toReplace), replacement);
	}
	
	public void replaceChild(String toReplace, String replacement) throws BuildException {
		replaceChild(new Symbol(toReplace), new Symbol(replacement));
	}
	
	public void replaceChild(int index, Node replacement) throws BuildException {
		removeChild(index);
		addChild(index, replacement);
	}
	
	public void replaceChild(int index, String replacement) throws BuildException {
		replaceChild(index, new Symbol(replacement));
	}
	
	public Symbol findSymbol(String symbol){
		for(Node child : nodes)
			if(child.isSymbol(symbol))
				return (Symbol) child;
		return null;
	}
	
	public Symbol requireSymbol(String symbol) throws ParseException {
		Symbol s = findSymbol(symbol);
		if(symbol == null)
			throw new ParseException(self, "Expected to find \"" + symbol + "\", but no such child was found.");
		return s;
	}
	
	public List findListStartingWith(String symbol){
		for(Node child : nodes)
			if(child.isList(1, -1) && ((List) child).children.nodes.get(0).isSymbol(symbol))
				return (List) child;
		return null;
	}
	
	public List requireListStartingWith(String symbol) throws ParseException {
		List list = findListStartingWith(symbol);
		if(list == null)
			throw new ParseException(self, "Expected to find a list beginning with \"" + symbol + "\", but no such child was found.");
		return list;
	}
	
	public java.util.List<List> findListsStartingWith(String symbol){
		LinkedList<List> lists = new LinkedList<>();
		for(Node child : nodes)
			if(child.isList(1, -1) && ((List) child).children.nodes.get(0).isSymbol(symbol))
				lists.add((List) child);
		return lists;
	}
	
	public java.util.List<List> requireListsStartingWith(String symbol) throws ParseException {
		java.util.List<List> lists = findListsStartingWith(symbol);
		if(lists == null)
			throw new ParseException(self, "Expected to find at least one list beginning with \"" + symbol + "\", but no such children were found.");
		return lists;
	}
	
	@Override
	public String toString(){
		if(nodes.size() == 0)
			return "";
		Iterator<Node> iterator = nodes.iterator();
		String str = iterator.next().toString();
		while(iterator.hasNext())
			str += " " + iterator.next();
		if(str.length() > 30)
			return str.substring(0, 30) + "...";
		else
			return str;
	}
}
