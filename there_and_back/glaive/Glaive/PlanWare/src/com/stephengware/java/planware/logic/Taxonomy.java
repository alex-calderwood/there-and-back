package com.stephengware.java.planware.logic;

import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.util.DirectedAcyclicGraph;

public class Taxonomy {
		
	public static final Taxonomy EMPTY = new Taxonomy();
	
	protected final DirectedAcyclicGraph<Type> relationships;
	
	protected Taxonomy(DirectedAcyclicGraph<Type> relationships){
		this.relationships = relationships;
	}
	
	private Taxonomy(){
		this(new DirectedAcyclicGraph<Type>());
		relationships.addNode(Type.UNIVERSAL_SUPERTYPE);
	}
	
	@SuppressWarnings("unchecked")
	private Taxonomy copy(){
		return new Taxonomy((DirectedAcyclicGraph<Type>) relationships.clone());
	}
	
	public int countTypes(){
		return relationships.countNodes();
	}
	
	public boolean isEmpty(){
		return countTypes() == 1;
	}
	
	public boolean definesType(Type type){
		return relationships.hasNode(type);
	}
	
	public Iterable<Type> getTypes(){
		return relationships.nodes();
	}
	
	public Taxonomy addType(Type type){
		if(relationships.hasNode(type))
			return this;
		Taxonomy newTaxonomy = copy();
		newTaxonomy.relationships.addEdge(Type.UNIVERSAL_SUPERTYPE, type);
		return newTaxonomy;
	}
	
	public Taxonomy removeType(Type type){
		if(type == Type.UNIVERSAL_SUPERTYPE)
			throw new FormatException("taxonomy", "The universal supertype \"" + Type.UNIVERSAL_SUPERTYPE + "\" cannot be removed.");
		if(!relationships.hasNode(type))
			return this;
		Taxonomy newTaxonomy = copy();
		newTaxonomy.relationships.removeNode(type);
		return newTaxonomy;
	}
	
	public boolean hasRelationship(Type supertype, Type subtype){
		return relationships.path(supertype, subtype);
	}
	
	public Taxonomy addRelationship(Type supertype, Type subtype){
		if(subtype == Type.UNIVERSAL_SUPERTYPE)
			throw new FormatException("taxonomy", "The universal supertype \"" + Type.UNIVERSAL_SUPERTYPE + "\" cannot have any parent types.");
		if(hasRelationship(supertype, subtype))
			return this;
		Taxonomy newTaxonomy = copy();
		newTaxonomy = newTaxonomy.addType(supertype);
		newTaxonomy = newTaxonomy.addType(subtype);
		if(supertype != Type.UNIVERSAL_SUPERTYPE && supertype != subtype)
			newTaxonomy.relationships.addEdge(supertype, subtype);
		return newTaxonomy;
	}
	
	public Taxonomy removeRelationship(Type supertype, Type subtype){
		if(supertype == Type.UNIVERSAL_SUPERTYPE)
			throw new FormatException("taxonomy", "The universal supertype \"" + Type.UNIVERSAL_SUPERTYPE + "\" must be a supertype of every type.");
		if(!hasRelationship(supertype, subtype))
			return this;
		Taxonomy newTaxonomy = copy();
		newTaxonomy.relationships.removeEdge(supertype, subtype);
		return newTaxonomy;
	}
	
	public Iterable<Type> getSubtypes(Type supertype){
		return relationships.getDescendants(supertype);
	}
	
	public boolean canUnify(Type type1, Type type2){
		return relationships.haveCommonDescendant(type1, type2);
	}
}
