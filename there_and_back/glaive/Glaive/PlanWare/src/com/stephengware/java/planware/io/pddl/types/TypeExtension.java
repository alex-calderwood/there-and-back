package com.stephengware.java.planware.io.pddl.types;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.logic.Type;

public class TypeExtension extends SimpleExtension<SExpression, Type> {
	
	public static final String UNIVERSAL_SUPERTYPE_NAME = "object";
	
	public static final Symbol findTypeSymbol(SExpression node) throws ParseException {
		Node current = node.asNode();
		while(current != null && !current.isSymbol("-"))
			current = current.getNextSibling();
		if(current == null){
			try{ return new Symbol(UNIVERSAL_SUPERTYPE_NAME); }
			catch(BuildException e){/* will not happen */}
		}
		return current.requireNextSibling().asSymbol();
	}
	
	public TypeExtension(){
		super(Type.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!document.isSymbol())
			fail();
		String name = document.asSymbol().content;
		if(name.startsWith("?"))
			fail();
		parser.define(Templates.TypeTemplate.NAME, name);
		Type type;
		if(name.equals(UNIVERSAL_SUPERTYPE_NAME))
			type = Type.UNIVERSAL_SUPERTYPE;
		else
			type = Type.getType(name);		
		if(parser.getUniverse() == null){
			if(parser.isReservedKeyword(name))
				throw new ParseException("The name \"" + name + "\" is not a valid name for a type because it is a reserved keyword.");
			else
				succeed(type);
		}
		else{
			if(parser.getUniverse().taxonomy.definesType(type))
				succeed(type);
			else
				throw new ParseException("The type \"" + name + "\" is not defined.");
		}
	}
	
	@Override
	public SExpression build(Type type, SExpression document, Builder<SExpression> builder) throws BuildException {
		return new Symbol(type.name);
	}
}
