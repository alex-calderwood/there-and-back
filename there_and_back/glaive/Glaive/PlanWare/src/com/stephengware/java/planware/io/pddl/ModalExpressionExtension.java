package com.stephengware.java.planware.io.pddl;

import java.util.Iterator;

import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.ModalExpression;

public abstract class ModalExpressionExtension<M extends ModalExpression> extends SimpleExtension<SExpression, M> {

	private final String modality;
	private final Class<? extends Entity>[] template;
	
	@SafeVarargs
	public ModalExpressionExtension(Class<M> objectType, String modality, Class<? extends Entity>...template){
		super(objectType);
		this.modality = modality;
		for(Class<?> c : template)
			if(!Entity.class.isAssignableFrom(c))
				throw new IllegalArgumentException("The class \"" + c.getSimpleName() + "\" is not a subclass of Entity.");
		this.template = template;
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		succeed(parseModalExpression(document, parser));
	}
	
	protected M parseModalExpression(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!checkFormat(document))
			fail();
		Entity[] arguments = new Entity[template.length];
		Node[] nodes;
		if(document.isList(2, -1))
			nodes = parser.parseOrFail(document.asList().getChild(1), Node[].class);
		else
			nodes = new Node[0];
		if(nodes.length != template.length)
			throw new ParseException(document, "The modality \"" + modality + "\" expects exactly " + template.length + " argumnets, but encountered " + nodes.length + " arguments.");
		for(int i=0; i<arguments.length; i++)
			arguments[i] = parser.parseOrFail(nodes[i], template[i]);
		parser.define(Templates.ModalExpressionTemplate.ARGUMENTS, arguments);
		return construct(arguments);
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) &&
				document.asList().getChild(0).isSymbol(modality);
	}
	
	protected abstract M construct(Entity[] arguments);
	
	@Override
	public SExpression build(M modalExpression, SExpression document, Builder<SExpression> builder) throws BuildException {
		return buildModalExpression(modalExpression, document, builder);
	}
	
	protected SExpression buildModalExpression(M modalExpression, SExpression document, Builder<SExpression> builder) throws BuildException {
		List modalList = new List(modality);
		for(Iterator<? extends Entity> iterator = modalExpression.iterator(); iterator.hasNext();)
			modalList.addChild(builder.build(iterator.next()));
		return modalList;
	}
}
