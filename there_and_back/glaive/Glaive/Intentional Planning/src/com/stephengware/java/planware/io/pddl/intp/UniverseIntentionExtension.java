package com.stephengware.java.planware.io.pddl.intp;

import java.util.Arrays;

import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.ExpressionVariable;
import com.stephengware.java.planware.logic.Intention;
import com.stephengware.java.planware.logic.ModalExpression;
import com.stephengware.java.planware.logic.Predication;
import com.stephengware.java.planware.logic.Taxonomy;
import com.stephengware.java.planware.logic.TermVariable;

public class UniverseIntentionExtension extends SimpleExtension<SExpression, Universe> {

	private static final ModalExpression INTENTION = new Intention(new TermVariable("agent"), new ExpressionVariable("goal"));
	
	public UniverseIntentionExtension(){
		super(Universe.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		Taxonomy taxonomy = parser.require(Templates.UniverseTemplate.TAXONOMY);
		Constant[] objects = parser.require(Templates.UniverseTemplate.OBJECTS);
		Predication[] predicates = parser.require(Templates.UniverseTemplate.PREDICATES);
		ModalExpression[] modalities = parser.require(Templates.UniverseTemplate.MODALITIES);
		modalities = Arrays.copyOf(modalities, modalities.length + 1);
		modalities[modalities.length - 1] = INTENTION;
		parser.define(Templates.UniverseTemplate.MODALITIES, modalities);
		succeed(new Universe(taxonomy, objects, predicates, modalities));
	}
	
	@Override
	public SExpression build(Universe object, SExpression document, Builder<SExpression> builder) throws BuildException {
		return document;
	}
}
