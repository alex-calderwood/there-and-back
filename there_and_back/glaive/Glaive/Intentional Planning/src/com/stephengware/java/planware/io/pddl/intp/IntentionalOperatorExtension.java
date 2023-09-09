package com.stephengware.java.planware.io.pddl.intp;

import com.stephengware.java.planware.IntentionalOperator;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.SimpleExtension;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Term;
import com.stephengware.java.planware.logic.Variable;

public class IntentionalOperatorExtension extends SimpleExtension<SExpression, IntentionalOperator> {

	public static final String AGENTS_IDENTIFIER = ":agents";
	
	public IntentionalOperatorExtension(){
		super(IntentionalOperator.class);
	}

	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		String name = parser.require(Templates.IntentionalOperatorTemplate.NAME);
		Variable[] parameters = parser.require(Templates.IntentionalOperatorTemplate.PARAMETERS);
		Expression precondition = parser.require(Templates.IntentionalOperatorTemplate.PRECONDITION);
		Expression effect = parser.require(Templates.IntentionalOperatorTemplate.EFFECT);
		Term[] agents = parser.require(Templates.IntentionalOperatorTemplate.AGENTS);
		succeed(new IntentionalOperator(name, parameters, precondition, effect, agents));
	}
	
	@Override
	public SExpression build(IntentionalOperator operator, SExpression document, Builder<SExpression> builder) throws BuildException {
		buildAgents(operator, (List) document, builder);
		return document;
	}
	
	protected void buildAgents(IntentionalOperator operator, List document, Builder<SExpression> builder) throws BuildException {
		if(operator.agents.length == 0)
			return;
		document.addChild(AGENTS_IDENTIFIER);
		List agentsList = new List();
		for(Term agent : operator.agents)
			agentsList.addChild(builder.build(agent));
		document.addChild(agentsList);
	}
}
