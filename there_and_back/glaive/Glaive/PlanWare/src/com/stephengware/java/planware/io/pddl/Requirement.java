package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.util.EmptyIterable;
import com.stephengware.java.planware.util.ImmutableArray;

public abstract class Requirement implements Extension<SExpression, SExpression> {

	protected static final Iterable<Requirement> NO_PREREQUISITES = new EmptyIterable<>();
	
	public final String name;
	public final String description;
	protected final ImmutableArray<Extension<SExpression, SExpression>> extensions;

	@SafeVarargs
	public Requirement(String name, String description, Extension<SExpression, SExpression>...extensions){
		this.name = name;
		this.description = description;
		this.extensions = new ImmutableArray<>(extensions);
	}
	
	@Override
	public boolean equals(Object other){
		return (other instanceof Requirement) && name.equals(((Requirement) other).name);
	}

	public abstract Iterable<Requirement> getPrerequisites();
	
	public boolean implies(Requirement requirement){
		if(equals(requirement))
			return true;
		for(Requirement prerequisite : getPrerequisites())
			if(prerequisite.implies(requirement))
				return true;
		return false;
	}
	
	@Override
	public final void configure(Parser<SExpression> parser){
		for(Requirement prerequisite : getPrerequisites())
			parser.installOnce(prerequisite);
		parser.defineObject(name, this);
	}
	
	protected void load(Parser<SExpression> parser){
		for(Requirement prerequisite : getPrerequisites())
			prerequisite.load(parser);
		for(Extension<SExpression, SExpression> extension : extensions)
			parser.installOnce(extension);
	}
	
	@Override
	public final void configure(Builder<SExpression> builder) {
		for(Requirement prerequisite : getPrerequisites())
			builder.installOnce(prerequisite);
	}
	
	protected void load(Builder<SExpression> builder){
		for(Requirement prerequisite : getPrerequisites())
			prerequisite.load(builder);
		for(Extension<SExpression, SExpression> extension : extensions)
			builder.installOnce(extension);
	}
	
	public abstract boolean isRequiredBy(Domain domain);
	
	public abstract boolean isRequiredBy(Problem problem);
	
	@Override
	public String toString(){
		return name;
	}
}
