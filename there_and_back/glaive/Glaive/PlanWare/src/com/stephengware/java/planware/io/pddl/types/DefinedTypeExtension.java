package com.stephengware.java.planware.io.pddl.types;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Type;

public class DefinedTypeExtension extends SimpleExtension<SExpression, Type> {

	public DefinedTypeExtension(){
		super(Type.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.TypeTemplate.NAME);
		Type defined = parser.getDefinedObject(name, Type.class);
		if(defined == null)
			throw new ParseException(document, "The type \"" + name + "\" is not defined.");
		succeed(defined);
	}
	
	@Override
	public SExpression build(Type type, SExpression document, Builder<SExpression> builder) throws BuildException {
		return null;
	}
}
