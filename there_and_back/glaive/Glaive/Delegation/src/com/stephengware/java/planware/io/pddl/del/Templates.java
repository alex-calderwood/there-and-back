package com.stephengware.java.planware.io.pddl.del;

import com.stephengware.java.planware.io.Field;
import com.stephengware.java.planware.logic.Delegation;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Term;

public class Templates {
	
	public static abstract class DelegationTemplate {
		
		public static final Field<Delegation, Term> MASTER = new Field<>(Delegation.class, "master", Term.class);
		public static final Field<Delegation, Expression> GOAL = new Field<>(Delegation.class, "goal", Expression.class);
		public static final Field<Delegation, Term> SLAVE = new Field<>(Delegation.class, "slave", Term.class);
	}
}
