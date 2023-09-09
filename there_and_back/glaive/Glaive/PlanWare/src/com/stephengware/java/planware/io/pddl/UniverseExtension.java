package com.stephengware.java.planware.io.pddl;

import java.util.LinkedList;

import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.Parent;
import com.stephengware.java.planware.io.pddl.sexp.Root;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.ModalExpression;
import com.stephengware.java.planware.logic.Predication;
import com.stephengware.java.planware.logic.Taxonomy;
import com.stephengware.java.planware.logic.Term;

public class UniverseExtension extends SimpleExtension<SExpression, Universe> {

	public static final String CONSTANTS_IDENTIFIER = ":constants";
	public static final String PREDICATES_IDENTIFIER = ":predicates";
	
	public UniverseExtension(){
		super(Universe.class, true);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		if(!document.isParent())
			fail();
		Taxonomy taxonomy = parseTaxonomy(document.asList(), parser);
		Constant[] objects = parseObjects(document.asList(), parser);
		Predication[] predicates = parsePredicates(document.asList(), parser);
		ModalExpression[] modalities = parseModalities(document.asList(), parser);
		succeed(new Universe(taxonomy, objects, predicates, modalities));
	}
	
	protected Taxonomy parseTaxonomy(Parent document, Parser<SExpression> parser) throws ParseException {
		Taxonomy taxonomy = Taxonomy.EMPTY;
		parser.define(Templates.UniverseTemplate.TAXONOMY, taxonomy);
		return taxonomy;
	}
	
	protected Constant[] parseObjects(Parent document, Parser<SExpression> parser) throws ParseException {
		List constantsList = document.findListStartingWith(UniverseExtension.CONSTANTS_IDENTIFIER);
		Constant[] objects;
		if(constantsList == null)
			objects = new Constant[0];
		else
			objects = Utilities.parseConstants(constantsList, parser);
		for(Constant object : objects)
			parser.defineObject(object.name, object);
		parser.install(new DefinedConstantExtension());
		parser.define(Templates.UniverseTemplate.OBJECTS, objects);
		return objects;
	}
	
	protected Predication[] parsePredicates(Parent document, Parser<SExpression> parser) throws ParseException {
		LinkedList<Predication> predicates = new LinkedList<>();
		List predicatesList = document.asList().findListStartingWith(PREDICATES_IDENTIFIER);
		if(predicatesList != null)
			for(Node node : predicatesList.rest())
				predicates.add(parser.parseOrFail(node, Predication.class));
		Predication[] predications = predicates.toArray(new Predication[predicates.size()]);
		parser.define(Templates.UniverseTemplate.PREDICATES, predications);
		return predications;
	}
	
	protected ModalExpression[] parseModalities(Parent document, Parser<SExpression> parser) throws ParseException {
		ModalExpression[] modalities = new ModalExpression[0];
		parser.define(Templates.UniverseTemplate.MODALITIES, modalities);
		return modalities;
	}
	
	@Override
	public SExpression build(Universe universe, SExpression document, Builder<SExpression> builder) throws BuildException {
		Root universeRoot = new Root();
		buildTaxonomy(universe, universeRoot, builder);
		buildObjects(universe, universeRoot, builder);
		buildPredicates(universe, universeRoot, builder);
		buildModalities(universe, universeRoot, builder);
		return universeRoot;
	}
	
	protected void buildTaxonomy(Universe universe, Root document, Builder<SExpression> builder) throws BuildException {
		// do nothing
	}
	
	protected void buildObjects(Universe universe, Root document, Builder<SExpression> builder) throws BuildException {
		builder.install(new DefinedConstantExtension());
		if(universe.objects.length == 0)
			return;
		List objectsList = new List(CONSTANTS_IDENTIFIER);
		objectsList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(Constant object : universe.objects)
			objectsList.addChild(builder.build(object));
		document.addChild(objectsList);
	}
	
	protected void buildPredicates(Universe universe, Root document, Builder<SExpression> builder) throws BuildException {
		if(universe.predicates.length == 0)
			return;
		List predicatesList = new List(PREDICATES_IDENTIFIER);
		predicatesList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(Predication predicate : universe.predicates){
			List predicateList = new List(predicate.predicate);
			for(Term term : predicate.terms)
				predicateList.addChild(builder.build(term));
			predicatesList.addChild(predicateList);
		}
		document.addChild(predicatesList);
	}
	
	protected void buildModalities(Universe universe, Root document, Builder<SExpression> builder) throws BuildException {
		// do nothing
	}
}
