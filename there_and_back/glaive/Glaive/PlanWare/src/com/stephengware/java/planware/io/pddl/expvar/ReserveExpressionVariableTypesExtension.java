package com.stephengware.java.planware.io.pddl.expvar;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.Type;

public class ReserveExpressionVariableTypesExtension extends SimpleExtension<SExpression, TermVariable> {

	public ReserveExpressionVariableTypesExtension(){
		super(TermVariable.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		Type type = parser.require(Templates.TermTemplate.TYPE);
		if(type.name.equals(ExpressionVariableExtension.EXPRESSION_VARIABLE_IDENTIFIER) ||
				type.name.equals(ExpressionVariableExtension.IMPOSABLE_EXPRESSION_VARIABLE_IDENTIFIER))
			fail();
	}
	
	@Override
	public SExpression build(TermVariable object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
