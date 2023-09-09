package com.stephengware.java.planware.io.pddl.intp;

import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.ModalExpressionExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Intention;
import com.stephengware.java.planware.logic.Term;

public class IntentionExtension extends ModalExpressionExtension<Intention> {

	public static final String INTENTION_MODALITY = "intends";
	
	public IntentionExtension(){
		super(Intention.class, INTENTION_MODALITY, Term.class, Expression.class);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		Intention intention = parseModalExpression(document, parser);
		parser.define(Templates.IntentionTemplate.AGENT, intention.agent);
		parser.define(Templates.IntentionTemplate.GOAL, intention.goal);
		succeed(intention);
	}
	
	@Override
	protected Intention construct(Entity[] arguments){
		return new Intention((Term) arguments[0], (Expression) arguments[1]);
	}
}
