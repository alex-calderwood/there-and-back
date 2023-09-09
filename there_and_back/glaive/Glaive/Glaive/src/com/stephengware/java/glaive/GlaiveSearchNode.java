package com.stephengware.java.glaive;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.NoSuchElementException;

import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.ss.StateSpaceSearchNode;
import com.stephengware.java.planware.util.CountableIterable;

public class GlaiveSearchNode extends StateSpaceSearchNode {
	
	public final GlaiveSearchNode parent;
	public final GlaivePlan plan;
	public final TokenList tokens;
	public final PartialPlan remaining;
	
	private Iterator<? extends IntentionalStep> nextSteps = null;
	final ArrayList<GlaiveSearchNode> children = new ArrayList<>(5);
	private CountableIterable<? extends IntentionalStep> relaxedPlan = null;
	private boolean authorGoalAchievable = true;
	private boolean characterGoalAchievable = true;
	int unexplainedCount = 0;
	
	protected GlaiveSearchNode(GlaiveSearchNode parent, IntentionalStep next){
		this.parent = parent;
		this.plan = parent.getPlan().clone();
		this.plan.addStep(next);
		StepEvent event = this.getPlan().getLastStep();
		this.tokens = parent.tokens.clone(event.source.agents.length);
		if(next.equals(parent.remaining.step))
			this.remaining = parent.remaining.rest;
		else
			this.remaining = parent.remaining;
	}
	
	public GlaiveSearchNode(GlaivePlan root, PartialPlan remaining){
		this.parent = null;
		this.plan = root;
		int tokenCapacity = 0;
		for(IntentionalStep step : root.steps())
			tokenCapacity += step.agents.length;
		this.tokens = new TokenList(tokenCapacity);
		this.remaining = remaining;
		this.unexplainedCount = root.countUnexplainedSteps();
	}
	
	public GlaiveSearchNode(GlaivePlan root){
		this(root, PartialPlan.EMPTY);
	}
	
	@Override
	public GlaivePlan getPlan(){
		return plan;
	}
	
	@Override
	public State getState(){
		return plan.getCurrentState();
	}
	
	final void setNextSteps(Iterator<? extends IntentionalStep> nextSteps){
		this.nextSteps = nextSteps;
	}
	
	public boolean hasNextStep(){
		if(nextSteps == null)
			throw new IllegalStateException("This node has not yet been evaluated by the Glaive heuristic, so it cannot offer its next steps.");
		return nextSteps.hasNext();
	}
	
	public IntentionalStep getNextStep(){
		if(!nextSteps.hasNext())
			throw new NoSuchElementException("There are no more next steps.");
		return nextSteps.next();
	}
	
	final void setRelaxedPlan(CountableIterable<? extends IntentionalStep> relaxedPlan){
		this.relaxedPlan = relaxedPlan;
	}
	
	public CountableIterable<? extends IntentionalStep> getRelaxedPlan(){
		if(relaxedPlan == null)
			throw new IllegalStateException("This node has not yet been evaluated by the Glaive heuristic, so it cannot offer its relaxed plan.");
		return relaxedPlan;
	}
	
	final void setAuthorGoalAchievable(boolean valence){
		this.authorGoalAchievable = valence;
	}
	
	public boolean isAuthorGoalAchievable(){
		return authorGoalAchievable;
	}
	
	final void setCharacterGoalAchievable(boolean valence){
		this.characterGoalAchievable = valence;
	}
	
	public boolean isCharacterGoalAchievable(){
		return characterGoalAchievable;
	}
	
	@Override
	public String toString(){
		String str = "PLAN:";
		GlaivePlan plan = getPlan();
		for(int i=1; i<=plan.countSteps(); i++){
			StepEvent event = plan.getStep(i);
			str += "\n  " + event.source;
			if(event.isOrphan()){
				str += " orphans={";
				boolean first = true;
				for(Constant agent : event.source.agents){
					if(event.isOrphan(agent)){
						if(first)
							first = false;
						else
							str += ",";
						str += agent;
					}
				}
				str += "}";
			}
			if(!event.isExplained()){
				str += " unexplained={";
				boolean first = true;
				for(Constant agent : event.source.agents){
					if(!event.isExplained(agent)){
						if(first)
							first = false;
						else
							str += ",";
						str += agent;
					}
				}
				str += "}";
			}
		}
		str += "\nRELAXED SOLUTION:";
		if(relaxedPlan == null)
			str += "\n  unknown";
		else{
			for(IntentionalStep step : getRelaxedPlan())
				str += "\n  " + step;
		}
		str += "\n" + tokens;
		str += "\nHEURISTIC:";
		str += "\n  plan length = " + getPlan().countSteps();
		str += "\n  orphans = " + getPlan().countOrphans();
		if(relaxedPlan == null)
			str += "\n  relaxed solution length = ?\n  token costs = ?";
		else{
			str += "\n  relaxed solution length = " + getRelaxedPlan().size();
			str += "\n  token costs = " + tokens.countDistances();
		}
		str += "\n  partial plan steps remaining = " + remaining.length;
		return str;
	}
}
