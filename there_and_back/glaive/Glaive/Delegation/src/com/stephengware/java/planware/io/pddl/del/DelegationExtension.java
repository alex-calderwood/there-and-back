package com.stephengware.java.planware.io.pddl.del;

import com.stephengware.java.planware.io.ParseException;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.ModalExpressionExtension;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;
import com.stephengware.java.planware.logic.Delegation;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Term;

public class DelegationExtension extends ModalExpressionExtension<Delegation> {

	public static final String DELEGATION_MODALITY = "delegated";
	
	public DelegationExtension(){
		super(Delegation.class, DELEGATION_MODALITY, Term.class, Expression.class, Term.class);
	}
	
	@Override
	public void parse(SExpression document, Parser<SExpression> parser) throws ParseException {
		Delegation intention = parseModalExpression(document, parser);
		parser.define(Templates.DelegationTemplate.MASTER, intention.master);
		parser.define(Templates.DelegationTemplate.GOAL, intention.goal);
		parser.define(Templates.DelegationTemplate.SLAVE, intention.slave);
		succeed(intention);
	}
	
	@Override
	protected Delegation construct(Entity[] arguments){
		return new Delegation((Term) arguments[0], (Expression) arguments[1], (Term) arguments[2]);
	}
}
