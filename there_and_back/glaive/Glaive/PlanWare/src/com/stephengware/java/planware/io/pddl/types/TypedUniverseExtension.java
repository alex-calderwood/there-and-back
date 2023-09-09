package com.stephengware.java.planware.io.pddl.types;

import java.util.LinkedHashMap;
import java.util.LinkedList;

import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.Templates;
import com.stephengware.java.planware.io.pddl.DefinedConstantExtension;
import com.stephengware.java.planware.io.pddl.UniverseExtension;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Parent;
import com.stephengware.java.planware.io.pddl.sexp.Root;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Taxonomy;
import com.stephengware.java.planware.logic.Type;

public class TypedUniverseExtension extends UniverseExtension {

	@Override
	protected Taxonomy parseTaxonomy(Parent document, Parser<SExpression> parser) throws ParseException {
		List taxonomyList = document.findListStartingWith(TaxonomyExtension.TAXONOMY_IDENTIFIER);
		Taxonomy taxonomy = parser.parseOrFail(taxonomyList, Taxonomy.class);
		for(Type type : taxonomy.getTypes())
			parser.defineObject(type.name, type);
		parser.install(new DefinedTypeExtension());
		parser.define(Templates.UniverseTemplate.TAXONOMY, taxonomy);
		return taxonomy;
	}
	
	@Override
	protected void buildTaxonomy(Universe universe, Root document, Builder<SExpression> builder) throws BuildException {
		document.addChild(builder.build(universe.taxonomy));
	}
	
	@Override
	protected void buildObjects(Universe universe, Root document, Builder<SExpression> builder) throws BuildException {
		builder.install(new DefinedConstantExtension());
		if(universe.objects.length == 0)
			return;
		List objectsList = new List(UniverseExtension.CONSTANTS_IDENTIFIER);
		objectsList.setFormatRule(FormatRule.TYPE_AT_END_OF_LINE);
		LinkedHashMap<Type, LinkedList<Constant>> objectsByType = new LinkedHashMap<>();
		for(Constant object : universe.objects){
			LinkedList<Constant> list = objectsByType.get(object.getType());
			if(list == null){
				list = new LinkedList<>();
				objectsByType.put(object.getType(), list);
			}
			list.add(object);
		}
		for(LinkedList<Constant> list : objectsByType.values()){
			for(Constant object : list)
				objectsList.addChild(builder.build(object));
			objectsList.addChild("-");
			objectsList.addChild(builder.build(list.get(0).getType()));
		}
		document.addChild(objectsList);
	}
}
