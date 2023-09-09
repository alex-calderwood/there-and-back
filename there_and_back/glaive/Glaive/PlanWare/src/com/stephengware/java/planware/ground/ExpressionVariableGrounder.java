package com.stephengware.java.planware.ground;

import java.util.LinkedHashSet;
import java.util.Set;

import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.logic.ExpressionVariable;
import com.stephengware.java.planware.logic.ModalExpression;
import com.stephengware.java.planware.logic.Predication;

public class ExpressionVariableGrounder<P extends Problem> implements ObjectGrounder<ExpressionVariable, P> {

	private final class DefinedLiteralExpressionVariableGrounder implements ObjectGrounder<ExpressionVariable, P> {

		public final Set<Object> groundLiterals;
		
		public DefinedLiteralExpressionVariableGrounder(Set<Object> groundLiterals){
			this.groundLiterals = groundLiterals;
		}
		
		@Override
		public Set<Object> ground(ExpressionVariable input, Grounder<P> grounder){
			return groundLiterals;
		}
	}
	
	private final int nesting;
	private LinkedHashSet<Object> allGroundLiterals = null;
	
	public ExpressionVariableGrounder(int nesting){
		this.nesting = nesting;
	}
	
	public ExpressionVariableGrounder(){
		this(0);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public Set<Object> ground(ExpressionVariable variable, Grounder<P> grounder){
		if(allGroundLiterals == null){
			allGroundLiterals = new LinkedHashSet<>();
			for(Predication template : grounder.problem.universe.predicates)
				allGroundLiterals.addAll(grounder.ground(template, Predication.class));
			ObjectGrounder<ExpressionVariable, P> backup = grounder.getObjectGrounder(ExpressionVariable.class);
			grounder.setObjectGrounder(ExpressionVariable.class, new DefinedLiteralExpressionVariableGrounder((Set<Object>) allGroundLiterals.clone()));
			for(int i=0; i<nesting; i++){
				for(ModalExpression template : grounder.problem.universe.modalities)
					allGroundLiterals.addAll(grounder.ground(template, ModalExpression.class));
				grounder.setObjectGrounder(ExpressionVariable.class, new DefinedLiteralExpressionVariableGrounder((Set<Object>) allGroundLiterals.clone()));
			}
			grounder.setObjectGrounder(ExpressionVariable.class, backup);
		}
		return allGroundLiterals;
	}
}
