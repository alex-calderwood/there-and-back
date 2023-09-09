package com.stephengware.java.glaive;

import java.util.Iterator;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.ig.GoalNode;
import com.stephengware.java.planware.ig.IntentionGraph;
import com.stephengware.java.planware.ig.IntentionNode;
import com.stephengware.java.planware.ig.Motivation;
import com.stephengware.java.planware.ig.StepNode;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.util.ArrayIterable;
import com.stephengware.java.planware.util.CountableIterable;
import com.stephengware.java.planware.util.ImmutableSet;

public class GlaiveRelaxedPlanBuilder extends com.stephengware.java.planware.ff.FastForwardRelaxedPlanBuilder {

	protected final IntentionGraph planGraph;
	protected final GoalNode goal;
	
	public GlaiveRelaxedPlanBuilder(IntentionGraph planGraph, Expression goal){
		super(planGraph, goal);
		this.planGraph = planGraph;
		this.goal = planGraph.getGoalNode(goal);
	}
	
	private static final CountableIterable<? extends IntentionalStep> NO_PLAN = new ArrayIterable<IntentionalStep>(new IntentionalStep[0]);
	
	final void evaluate(GlaiveSearchNode node){
		initialize(node.getState());
		CountableIterable<? extends IntentionalStep> plan;
		if(satisfy(goal))
			plan = getRelaxedPlan();
		else{
			node.setAuthorGoalAchievable(false);
			GoalNode agentGoal = chooseAgentGoal(node.getPlan().agentGoals());
			while(agentGoal == null && !planGraph.hasLeveledOff()){
				planGraph.extend();
				agentGoal = chooseAgentGoal(node.getPlan().agentGoals());
			}
			if(agentGoal == null || !satisfy(agentGoal)){
				node.setCharacterGoalAchievable(false);
				plan = NO_PLAN;
			}
			else
				plan = getRelaxedPlan();
		}		
		node.setRelaxedPlan(plan);
		node.setNextSteps(getNextSteps());
		if(node.plan.getCurrentTime() != 0)
			addTokens(node.tokens, node.plan.getLastStep());
	}
	
	protected GoalNode chooseAgentGoal(Iterable<AgentGoal> goals){
		GoalNode best = null;
		for(AgentGoal goal : goals){
			if(!goal.isSatisfied()){
				GoalNode goalNode = planGraph.getGoalNode(goal.goal);
				if(goalNode.isActive()){
					if(best == null)
						best = goalNode;
					else if(goalNode.getLevel() < best.getLevel())
						best = goalNode;
				}
			}
		}
		return best;
	}
	
	@Override
	protected void addStepToPlan(com.stephengware.java.planware.pg.StepNode step){
		super.addStepToPlan(step);
		ImmutableSet<Constant> agents = ((StepNode) step).step.agents;
		for(int i=0; i<agents.length; i++){
			IntentionNode motivation = chooseMotivation((StepNode) step, agents.get(i));
			satisfy(motivation);
		}
	}
	
	protected IntentionNode chooseMotivation(StepNode step, Constant agent){
		IntentionNode best = null;
		ImmutableSet<Motivation> motivations = step.motivations();
		for(int i=0; i<motivations.size(); i++){
			Motivation motivation = motivations.get(i);
			if(motivation.intention.agent.equals(agent)){
				if(mayChoose(motivation.intention, step)){
					if(best == null)
						best = motivation.intention;
					else if(compare(motivation.intention, best) < 0)
						best = motivation.intention;
				}
			}
		}
		return best;
	}
	
	protected boolean mayChoose(IntentionNode intention, StepNode step){
		return intention.isActive();
	}
	
	protected int compare(IntentionNode i1, IntentionNode i2){
		if(planContains(i1))
			return -1;
		else if(planContains(i2))
			return 1;
		return i1.getLevel() - i2.getLevel();
	}
	
	public void addTokens(TokenList tokens, StepEvent stepEvent){
		for(int i=0; i<stepEvent.source.agents.length; i++){
			Constant agent = stepEvent.source.agents.get(i);
			StepNode stepNode = planGraph.getStepNode(stepEvent.source);
			ImmutableSet<Motivation> motivations = stepNode.motivations();
			Motivation best = null;
			for(int j=0; j<motivations.size(); j++){
				Motivation motivation = motivations.get(j);
				if(motivation.intention.isActive() && motivation.intention.getLevel() == 0){
					if(best == null)
						best = motivation;
					else if(motivation.distance < best.distance)
						best = motivation;
				}
			}
			tokens.add(new Token(stepEvent, agent, best.intention.goal, best.distance));
		}
	}
	
	@SuppressWarnings("unchecked")
	public CountableIterable<IntentionalStep> getRelaxedPlan(){
		return (CountableIterable<IntentionalStep>) (CountableIterable<?>) super.getRelaxedPlan();
	}
	
	@SuppressWarnings("unchecked")
	public Iterator<? extends IntentionalStep> getNextSteps(){
		return (Iterator<IntentionalStep>) (Iterator<?>) super.getNextSteps();
	}

}
