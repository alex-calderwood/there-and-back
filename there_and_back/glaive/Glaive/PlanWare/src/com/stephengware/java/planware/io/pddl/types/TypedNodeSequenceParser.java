package com.stephengware.java.planware.io.pddl.types;

import java.util.LinkedList;

import com.stephengware.java.planware.io.DocumentParser;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.Root;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public class TypedNodeSequenceParser extends DocumentParser<SExpression> {

	@Override
	public void parse(SExpression first, Parser<SExpression> parser) throws ParseException {
		Node current;
		if(first instanceof Root){
			Root root = (Root) first;
			if(root.getLength() == 0)
				succeed(new Node[0]);
			current = root.getChild(0);
		}
		else
			current = (Node) first;
		LinkedList<Node> nodes = new LinkedList<>();
		LinkedList<Node> subtypes = new LinkedList<>();
		while(current != null){
			if(current.isSymbol("-")){
				if(subtypes.isEmpty())
					throw new ParseException(current, "Expected node, but encountered type declaration.");
				for(Node node : subtypes)
					nodes.add(node);
				subtypes.clear();
				current = current.requireNextSibling();
			}
			else
				subtypes.add(current);
			current = current.getNextSibling();
		}
		for(Node node : subtypes)
			nodes.add(node);
		succeed(nodes.toArray(new Node[nodes.size()]));
	}
}
