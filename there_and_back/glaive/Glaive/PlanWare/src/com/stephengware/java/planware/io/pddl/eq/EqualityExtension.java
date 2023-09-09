package com.stephengware.java.planware.io.pddl.eq;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Equality;

public abstract class EqualityExtension<E extends Equality, A extends Entity> extends SimpleExtension<SExpression, E> {

	public static final String EQUALITY_PREDICATE = "=";
	
	private final Class<A> argumentType;
	
	public EqualityExtension(Class<E> objectType, Class<A> argumentType){
		super(objectType);
		this.argumentType = argumentType;
	}
	
	protected E parseEquality(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		Node[] arguments = parser.parse(document.asList(3, -1).getChild(1), Node[].class);
		if(arguments.length != 2)
			throw new ParseException(document, "Equality expects exactly 2 arguments, but " + arguments.length + " arguments were encountered.");
		A left = parser.parse(arguments[0], argumentType);
		if(left == null)
			fail();
		A right = parser.parseOrFail(arguments[1], argumentType);
		if(right == null)
			fail();
		parser.define(Templates.EqualityTemplate.LEFT, left);
		parser.define(Templates.EqualityTemplate.RIGHT, right);
		return construct(left, right);
	}
	
	protected abstract E construct(A left, A right);
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) &&
				document.asList().getChild(0).isSymbol(TermEqualityExtension.EQUALITY_PREDICATE);
	}
	
	@Override
	public SExpression build(E equality, SExpression document, Builder<SExpression> builder) throws BuildException {
		return new List(EQUALITY_PREDICATE, builder.build(equality.left), builder.build(equality.right));
	}
}
