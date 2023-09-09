package com.stephengware.java.glaive;

import java.util.Arrays;
import java.util.Iterator;
import java.util.NoSuchElementException;

import com.stephengware.java.planware.AxiomTree;
import com.stephengware.java.planware.IntentionalPlan;
import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.util.ArrayIterable;

public class GlaivePlan extends IntentionalPlan {

	private final CausalState state;
	private StepEvent[] steps;
	private AgentGoal[] goals;
	private int time;
	
	protected GlaivePlan(GlaivePlan plan){
		super(plan.name, plan.problem);
		this.state = new CausalState(this, plan.state);
		this.steps = plan.steps;
		this.goals = plan.goals.clone();
		this.time = plan.time;
	}
	
	public GlaivePlan(String name, IntentionalProblem problem, AxiomTree axiomTree){
		super(name, problem);
		this.state = new CausalState(axiomTree, this);
		this.steps = new StepEvent[0];
		this.goals = new AgentGoal[0];
		this.time = 0;
		this.state.impose(problem.initialState);
		updateAgentGoals();
	}

	@Override
	public int countSteps(){
		return steps.length;
	}
		
	private final class StepIterator implements Iterator<IntentionalStep> {

		private int index = 0;
		
		@Override
		public boolean hasNext(){
			return index != steps.length;
		}

		@Override
		public IntentionalStep next(){
			if(!hasNext())
				throw new NoSuchElementException("There are no more steps.");
			IntentionalStep step = steps[index].source;
			index++;
			return step;
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}
	
	private final Iterable<IntentionalStep> stepsIterable = new Iterable<IntentionalStep>(){

		@Override
		public Iterator<IntentionalStep> iterator(){
			return new StepIterator();
		}
	};
	
	@Override
	public Iterable<? extends IntentionalStep> steps(){
		return stepsIterable;
	}
	
	public void addStep(IntentionalStep step){
		time++;
		StepEvent stepEvent = new StepEvent(step, getCurrentTime(), state);
		steps = Arrays.copyOf(steps, steps.length + 1);
		steps[steps.length - 1] = stepEvent;
		state.execute(stepEvent);
	}
	
	public StepEvent getStep(int time){
		if(time < 1 || time > getCurrentTime())
			throw new IndexOutOfBoundsException("The time index of a step must be between 1 and the current time (inclusive).");
		return steps[time - 1];
	}
	
	public StepEvent getLastStep(){
		return getStep(getCurrentTime());
	}
	
	private abstract class AbstractStepIterator implements Iterator<StepEvent> {

		private int index = -1;
		
		public AbstractStepIterator(){
			advance();
		}
		
		private final void advance(){
			index++;
			while(index < steps.length && !member(steps[index]))
				index++;
		}
		
		protected abstract boolean member(StepEvent stepEvent);
		
		@Override
		public boolean hasNext(){
			return index != steps.length;
		}

		@Override
		public StepEvent next(){
			if(!hasNext())
				throw new NoSuchElementException("There are no more steps.");
			StepEvent step = steps[index];
			advance();
			return step;
		}

		@Override
		public void remove(){
			throw new UnsupportedOperationException("java.util.Iterator#remove() not supported.");
		}
	}
	
	public int countOrphans(){
		int orphans = 0;
		for(StepEvent stepEvent : steps)
			if(stepEvent.isOrphan())
				orphans++;
		return orphans;
	}
	
	private final class OrphanIterator extends AbstractStepIterator {

		@Override
		protected boolean member(StepEvent stepEvent){
			return stepEvent.isOrphan();
		}
	}
	
	private final Iterable<StepEvent> orphansIterable = new Iterable<StepEvent>(){

		@Override
		public Iterator<StepEvent> iterator(){
			return new OrphanIterator();
		}
	};
	
	public Iterable<StepEvent> orphans(){
		return orphansIterable;
	}
	
	public int countUnexplainedSteps(){
		int unexplained = 0;
		for(StepEvent stepEvent : steps)
			if(!stepEvent.isExplained())
				unexplained++;
		return unexplained;
	}
	
	private final class UnexplainedIterator extends AbstractStepIterator {

		@Override
		protected boolean member(StepEvent stepEvent){
			return !stepEvent.isExplained();
		}
	}
	
	private final Iterable<StepEvent> unexplainedIterable = new Iterable<StepEvent>(){

		@Override
		public Iterator<StepEvent> iterator(){
			return new UnexplainedIterator();
		}
	};
	
	public Iterable<StepEvent> unexplainedSteps(){
		return unexplainedIterable;
	}
		
	public int countAgentGoals(){
		return goals.length;
	}
	
	public Iterable<AgentGoal> agentGoals(){
		return new ArrayIterable<>(goals);
	}
	
	final void addAgentGoal(AgentGoal goal){
		if(!hasAgentGoal(goal)){
			goals = Arrays.copyOf(goals, goals.length + 1);
			goals[goals.length - 1] = goal;
		}
	}
	
	private final boolean hasAgentGoal(AgentGoal goal){
		for(AgentGoal existing : goals)
			if(!existing.isSatisfied() && existing.agent.equals(goal.agent) && existing.goal.equals(goal.goal))
				return true;
		return false;
	}

	final void updateAgentGoals(){
		for(int i=0; i<goals.length; i++){
			AgentGoal goal = goals[i];
			if(goal.isSatisfied()){
				if(!state.isTrue(goal.goal) && !hasAgentGoal(goal))
					addAgentGoal(new AgentGoal(getLastStep(), goal.agent, goal.goal));
			}
			else{
				if(state.isTrue(goal.goal)){
					goals[i] = goal.satisfy(new AgentGoalEvent(goal, getCurrentTime(), state));
					new Subplan(goals[i]);
				}
			}
		}
	}
	
	public int getCurrentTime(){
		return time;
	}
	
	public State getCurrentState(){
		return state;
	}
	
	public ProblemGoalEvent getProblemGoal(){
		if(state.isTrue(problem.goal))
			return new ProblemGoalEvent(problem.goal, getCurrentTime(), state);
		else
			throw new IllegalStateException("The problem goal has not been achieved by this plan.");
	}
	
	@Override
	public GlaivePlan clone(){
		return new GlaivePlan(this);
	}
	
	@Override
	public String toString(){
		return "[Plan: " + countSteps() + " steps " + countAgentGoals() + " goals " + countOrphans() + " orphans]";
	}
}