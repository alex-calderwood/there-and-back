package com.stephengware.java.planware.ground;

import java.util.HashMap;
import java.util.Set;

import com.stephengware.java.planware.AxiomTemplate;
import com.stephengware.java.planware.Operator;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.ExpressionVariable;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.util.SupertypeIterator;

public class Grounder<P extends Problem> {

	public final P problem;
	private final HashMap<Class<?>, ObjectGrounder<?, P>> objectGrounders = new HashMap<>();
	
	public Grounder(P problem){
		this.problem = problem;
		setObjectGrounder(Entity.class, new EntityGrounder<Entity, P>());
		setObjectGrounder(TermVariable.class, new TermVariableGrounder<P>());
		setObjectGrounder(ExpressionVariable.class, new ExpressionVariableGrounder<P>());
		setObjectGrounder(Operator.class, new OperatorGrounder<P>());
		setObjectGrounder(AxiomTemplate.class, new AxiomGrounder<P>());
	}
	
	@SuppressWarnings("unchecked")
	public <I> ObjectGrounder<I, P> getObjectGrounder(Class<I> inputType){
		ObjectGrounder<I, P> objectGrounder = (ObjectGrounder<I, P>) objectGrounders.get(inputType);
		if(objectGrounder != null)
			return objectGrounder;
		for(SupertypeIterator<I> supertypes = new SupertypeIterator<>(inputType); objectGrounder == null && supertypes.hasNext(); objectGrounder = (ObjectGrounder<I, P>) objectGrounders.get(supertypes.next()));
		return objectGrounder;
	}
	
	public <I> void setObjectGrounder(Class<I> inputType, ObjectGrounder<I, P> objectGrounder){
		objectGrounders.put(inputType, objectGrounder);
	}
	
	@SuppressWarnings("unchecked")
	public <I, O> Set<O> ground(I input, Class<O> outputType){
		ObjectGrounder<I, P> objectGrounder = getObjectGrounder((Class<I>) input.getClass());
		if(objectGrounder == null)
			throw new IllegalArgumentException("\"" + input + "\" cannot be grounded because there is no object grounder associated with objects of type " + input.getClass().getSimpleName() + ".");
		Set<Object> grounded = objectGrounder.ground(input, this);
		for(Object ground : grounded)
			if(!outputType.isAssignableFrom(ground.getClass()))
				throw new IllegalArgumentException(input.getClass().getSimpleName() + " \"" + input + "\" was grounded as, " + ground.getClass().getSimpleName() + " \"" + ground + "\", but " + ground.getClass().getSimpleName() + " is not a subclass of " + outputType.getSimpleName() + ".");
		return (Set<O>) grounded;
	}
}
