package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Constant;

public class ConstantExtension extends SimpleExtension<SExpression, Constant> {

	public ConstantExtension(){
		super(Constant.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.TermTemplate.NAME);
		if(name.startsWith("?"))
			fail();
		Universe universe = parser.getUniverse();
		if(universe == null)
			succeed(new Constant(name));
		else{
			for(Constant object : universe.objects)
				if(object.name.equals(name))
					succeed(object);
			throw new ParseException("The constant \"" + name + "\" is not defined.");
		}
	}
	
	@Override
	public SExpression build(Constant constant, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
