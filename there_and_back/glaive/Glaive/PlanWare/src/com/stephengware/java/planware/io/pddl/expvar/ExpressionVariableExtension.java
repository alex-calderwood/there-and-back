package com.stephengware.java.planware.io.pddl.expvar;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.io.pddl.sexp.Symbol;
import com.stephengware.java.planware.io.pddl.types.TypeExtension;
import com.stephengware.java.planware.logic.ExpressionVariable;

public class ExpressionVariableExtension extends SimpleExtension<SExpression, ExpressionVariable> {

	public static final String EXPRESSION_VARIABLE_IDENTIFIER = "expression";
	public static final String IMPOSABLE_EXPRESSION_VARIABLE_IDENTIFIER = "imposable";
	
	public ExpressionVariableExtension(){
		super(ExpressionVariable.class);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.VariableTemplate.NAME);
		if(parser.getUniverse() == null){
			Boolean imposable;
			Symbol typeSymbol = TypeExtension.findTypeSymbol(document);
			if(typeSymbol.isSymbol(EXPRESSION_VARIABLE_IDENTIFIER))
				imposable = false;
			else if(typeSymbol.isSymbol(IMPOSABLE_EXPRESSION_VARIABLE_IDENTIFIER))
				imposable = true;
			else
				throw new ParseException("An expression variable must be given a type of either \"" + EXPRESSION_VARIABLE_IDENTIFIER + "\" or \"" + IMPOSABLE_EXPRESSION_VARIABLE_IDENTIFIER + "\".");
			parser.define(Templates.ExpressionVariableTemplate.IMPOSABLE, imposable);
			succeed(new ExpressionVariable(name, imposable));
		}
		else{
			ExpressionVariable defined = parser.getDefinedObject(name, ExpressionVariable.class);
			if(defined == null)
				throw new ParseException("The expression variable \"?" + name + "\" is not defined.");
			else
				succeed(defined);
		}
	}

	@Override
	public SExpression build(ExpressionVariable object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
