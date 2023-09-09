package com.stephengware.java.glaive;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.NoSuchElementException;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.AxiomTree;
import com.stephengware.java.planware.AxiomTreeState;
import com.stephengware.java.planware.Clause;
import com.stephengware.java.planware.Effect;
import com.stephengware.java.planware.HashState;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Intention;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.logic.Negation;
import com.stephengware.java.planware.util.ImmutableArray;
import com.stephengware.java.planware.util.ImmutableSet;

public class CausalState extends AxiomTreeState {
	
	private final GlaivePlan plan;
	private final HashMap<Literal, CausalHistoryNode> history;
	private Event currentEvent = null;
	
	@SuppressWarnings("unchecked")
	protected CausalState(GlaivePlan plan, CausalState state){
		super(state.axiomTree);
		this.plan = plan;
		this.history = (HashMap<Literal, CausalHistoryNode>) state.history.clone();
	}
	
	protected CausalState(AxiomTree axiomTree, GlaivePlan plan){
		super(axiomTree);
		this.plan = plan;
		this.history = new HashMap<>();
	}

	@Override
	protected boolean testLiteral(Literal literal){
		if(literal == Expression.TRUE)
			return true;
		boolean valence = true;
		if(literal instanceof Negation){
			literal = literal.negate();
			valence = false;
		}
		CausalHistoryNode node = history.get(literal);
		if(node == null)
			return !valence;
		else
			return node.valence == valence;
	}
	
	@Override
	protected boolean imposeExpression(Expression expression){
		if(currentEvent == null){
			currentEvent = new ExpressionEvent(expression, plan.getCurrentTime());
			boolean result = super.imposeExpression(expression);
			currentEvent = null;
			return result;
		}
		else
			return super.imposeExpression(expression);
	}

	@Override
	protected boolean imposeLiteral(Literal literal){
		if(currentEvent == null){
			currentEvent = new ExpressionEvent(literal, plan.getCurrentTime());
			boolean result = doImposeLiteral(literal);
			currentEvent = null;
			return result;
		}
		else
			return doImposeLiteral(literal);
	}
	
	private final boolean doImposeLiteral(Literal literal){
		if(literal instanceof Intention)
			plan.addAgentGoal(new AgentGoal(currentEvent, (Constant) ((Intention) literal).agent, ((Intention) literal).goal));
		boolean valence = true;
		if(literal instanceof Negation){
			literal = literal.negate();
			valence = false;
		}
		CausalHistoryNode node = history.get(literal);
		history.put(literal, new CausalHistoryNode(valence, currentEvent, node));
		if(node == null)
			return valence;
		else
			return node.valence != valence;
	}
	
	@Override
	public boolean execute(Step step){
		throw new IllegalArgumentException("This state object reflects the current state of a plan; add steps to that plan to modify this state.");
	}
	
	final void execute(StepEvent stepEvent){
		Event backup = currentEvent;
		currentEvent = stepEvent;
		super.execute(stepEvent.source);
		currentEvent = backup;
	}
	
	@Override
	protected void update(){
		super.update();
		plan.updateAgentGoals();
	}
	
	@Override
	protected boolean applyAxiom(Axiom axiom){
		Event backup = currentEvent;
		currentEvent = new AxiomEvent(axiom, plan.getCurrentTime(), this);
		boolean result = super.applyAxiom(axiom);
		currentEvent = backup;
		return result;
	}
	
	private final class MyIterator implements Iterator<Literal> {

		private final Iterator<Literal> keys = history.keySet().iterator();
		private Literal next = null;
		
		public MyIterator(){
			advance();
		}
		
		private final void advance(){
			while(keys.hasNext()){
				next = keys.next();
				CausalHistoryNode node = history.get(next);
				if(node.valence)
					return;
			}
			next = null;
		}
		
		@Override
		public boolean hasNext(){
			return next != null;
		}

		@Override
		public Literal next(){
			if(!hasNext())
				throw new NoSuchElementException("There are no more literals.");
			Literal literal = next;
			advance();
			return literal;
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}
	
	@Override
	public Iterator<Literal> iterator(){
		return new MyIterator();
	}
	
	private final class CausalParentIterator implements Iterator<Event> {

		private final Literal literal;
		private boolean valence;
		private CausalHistoryNode node;
		
		public CausalParentIterator(Literal literal){
			this.literal = literal;
			if(literal instanceof Negation){
				valence = false;
				node = history.get(literal.negate());
			}
			else{
				valence = true;
				node = history.get(literal);
			}
		}
		
		@Override
		public boolean hasNext(){
			if(node == null)
				return !valence;
			else
				return node.valence == valence;
		}

		@Override
		public Event next(){
			Event event;
			if(node == null){
				event = new ExpressionEvent(literal, 0);
				valence = true;
			}
			else{
				event = node.event;
				node = node.previous;
			}
			return event;
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}

	final ImmutableSet<CausalLink> getCausalLinks(ImmutableArray<Clause> clauses, ImmutableArray<Effect> effects, Event head){
		HashSet<Literal> literals = getLiterals(clauses, effects);
		if(literals == null)
			throw new IllegalArgumentException("The event \"" + head + "\" cannot be executed because its precondition is not satisfied.");
		HashSet<CausalLink> links = new HashSet<>();
		for(Literal literal : getLiterals(clauses, effects))
			collectCausalLinks(literal, head, links);
		return new ImmutableSet<>(links, CausalLink.class);
	}
	
	private final HashSet<Literal> getLiterals(ImmutableArray<Clause> clauses, ImmutableArray<Effect> effects){
		HashSet<Literal> literals = new HashSet<>();
		if(!collectLiterals(clauses, literals))
			return null;
		for(int i=0; i<effects.length; i++)
			collectLiterals(effects.get(i).conditions, literals);
		return literals;
	}
	
	private final boolean collectLiterals(ImmutableArray<Clause> clauses, HashSet<Literal> literals){
		boolean result = false;
		for(int i=0; i<clauses.length; i++){
			Clause clause = clauses.get(i);
			if(clause.test(this)){
				result = true;
				for(int j=0; j<clause.literals.length; j++)
					literals.add(clause.literals.get(j));
			}
		}
		return result;
	}
	
	private final void collectCausalLinks(Literal label, Event head, HashSet<CausalLink> links){
		for(Iterator<Event> parents = new CausalParentIterator(label); parents.hasNext();)
			links.add(new CausalLink(parents.next(), label, head));
	}
	
	@Override
	public State clone(){
		HashState clone = new HashState(axiomTree);
		for(Literal literal : this)
			clone.impose(literal);
		return clone;
	}
}
