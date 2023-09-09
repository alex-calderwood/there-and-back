package com.stephengware.java.planware.io.pddl.types;

import java.util.LinkedHashMap;
import java.util.LinkedList;

import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.Root;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Taxonomy;
import com.stephengware.java.planware.logic.Type;

public class TaxonomyExtension extends SimpleExtension<SExpression, Taxonomy> {

	public static final String TAXONOMY_IDENTIFIER = ":types";
	
	public TaxonomyExtension(){
		super(Taxonomy.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		Taxonomy taxonomy = Taxonomy.EMPTY;
		if(!checkFormat(document))
			fail();
		if(document.isList(2, -1)){
			for(Node node : parser.parseOrFail(document.asList().getChild(1), Node[].class)){
				Type subtype = parser.parseOrFail(node, Type.class);
				Type supertype = parser.parseOrFail(TypeExtension.findTypeSymbol(node), Type.class);
				taxonomy = taxonomy.addRelationship(supertype, subtype);
			}
		}
		succeed(taxonomy);
	}
	
	protected boolean checkFormat(SExpression document) throws ParseException {
		return document.isList(1, -1) &&
				document.asList().getChild(0).isSymbol(TAXONOMY_IDENTIFIER);
	}
	
	@Override
	public SExpression build(Taxonomy taxonomy, SExpression document, Builder<SExpression> builder) throws BuildException {
		if(taxonomy.isEmpty())
			return new Root();
		LinkedHashMap<Type, LinkedList<Type>> subtypes = groupTypes(taxonomy);
		List taxonomyList = new List(TAXONOMY_IDENTIFIER);
		taxonomyList.setFormatRule(FormatRule.TYPE_AT_END_OF_LINE);
		for(Type supertype : subtypes.keySet()){
			for(Type subtype : subtypes.get(supertype))
				taxonomyList.addChild(builder.build(subtype));
			taxonomyList.addChild("-");
			taxonomyList.addChild(builder.build(supertype));
		}
		return taxonomyList;
	}
	
	private static final LinkedHashMap<Type, LinkedList<Type>> groupTypes(Taxonomy taxonomy){
		LinkedHashMap<Type, LinkedList<Type>> subtypes = new LinkedHashMap<>();
		for(Type supertype : taxonomy.getTypes()){
			LinkedList<Type> sub = new LinkedList<>();
			for(Type subtype : taxonomy.getSubtypes(supertype))
				if(isDirectParent(supertype, subtype, taxonomy))
					sub.add(subtype);
			if(sub.size() > 0)
				subtypes.put(supertype, sub);
		}
		return subtypes;
	}
	
	private static final boolean isDirectParent(Type parent, Type child, Taxonomy taxonomy){
		for(Type descendant : taxonomy.getSubtypes(parent))
			if(descendant != child && taxonomy.hasRelationship(descendant, child))
				return false;
		return true;
	}
}
