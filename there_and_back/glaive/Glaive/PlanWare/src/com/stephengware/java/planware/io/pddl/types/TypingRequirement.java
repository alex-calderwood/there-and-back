package com.stephengware.java.planware.io.pddl.types;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.io.DocumentParser;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.Requirement;
import com.stephengware.java.planware.io.pddl.sexp.Node;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public class TypingRequirement extends Requirement {

	private static final DocumentParser<SExpression> TYPED_NODE_SEQUENCE_PARSER = new TypedNodeSequenceParser();
	private static final Extension<SExpression, SExpression> TYPE_EXTENSION = new TypeExtension();
	private static final Extension<SExpression, SExpression> TYPED_TERM_EXTENSION = new TypedTermExtension();
	private static final Extension<SExpression, SExpression> TYPED_CONSTANT_EXTENSION = new TypedConstantExtension();
	private static final Extension<SExpression, SExpression> TYPED_TERM_VARIABLE_EXTENSION = new TypedTermVariableExtension();
	private static final Extension<SExpression, SExpression> TAXONOMY_EXTENSION = new TaxonomyExtension();
	private static final Extension<SExpression, SExpression> TYPED_UNIVERSE_EXTENSION = new TypedUniverseExtension();
	
	public static final Requirement TYPING = new TypingRequirement();
	
	private TypingRequirement(){
		super("typing", "typed terms", TYPE_EXTENSION, TYPED_TERM_EXTENSION, TYPED_CONSTANT_EXTENSION, TYPED_TERM_VARIABLE_EXTENSION, TAXONOMY_EXTENSION, TYPED_UNIVERSE_EXTENSION);
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return NO_PREREQUISITES;
	}
	
	@Override
	public void load(Parser<SExpression> parser){
		super.load(parser);
		parser.overrideDocumentParser(Node[].class, TYPED_NODE_SEQUENCE_PARSER);
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		return !domain.universe.taxonomy.isEmpty();
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		return false;
	}
}
