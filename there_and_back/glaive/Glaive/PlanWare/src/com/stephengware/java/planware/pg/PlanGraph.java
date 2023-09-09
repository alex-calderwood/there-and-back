package com.stephengware.java.planware.pg;

import java.util.Iterator;

import com.stephengware.java.planware.Axiom;
import com.stephengware.java.planware.State;
import com.stephengware.java.planware.Step;
import com.stephengware.java.planware.graph.ChangeNode;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.ss.StateSpace;

public class PlanGraph extends com.stephengware.java.planware.graph.ProblemGraph {

	final LevelManager levels = new LevelManager();
	final NextStepNodeList nextSteps = new NextStepNodeList();
	private boolean leveledOff = false;
	
	public PlanGraph(StateSpace space){
		for(Step step : space.steps)
			makeStepNode(step);
		for(Axiom axiom : space.axioms)
			makeAxiomNode(axiom);
	}
	
	@Override
	public LiteralNode getLiteralNode(Literal literal){
		return (LiteralNode) super.getLiteralNode(literal);
	}
	
	@Override
	public LiteralNode makeLiteralNode(Literal literal){
		return (LiteralNode) super.makeLiteralNode(literal);
	}
	
	@Override
	protected LiteralNode constructLiteralNode(Literal literal){
		return new LiteralNode(this, literal);
	}
	
	@Override
	protected EffectNode constructEffectNode(ChangeNode parent, Expression effect, com.stephengware.java.planware.graph.LiteralNode child){
		return new EffectNode(this, parent, effect, child);
	}
	
	@Override
	public StepNode getStepNode(Step step){
		return (StepNode) super.getStepNode(step);
	}
	
	@Override
	public StepNode makeStepNode(Step step){
		return (StepNode) super.makeStepNode(step);
	}
	
	@Override
	protected StepNode constructStepNode(Step step){
		return new StepNode(this, step);
	}
	
	@Override
	public GoalNode getGoalNode(Expression goal){
		return (GoalNode) super.getGoalNode(goal);
	}
	
	@Override
	public GoalNode makeGoalNode(Expression goal){
		return (GoalNode) super.makeGoalNode(goal);
	}
	
	@Override
	protected GoalNode constructGoalNode(Expression goal){
		return new GoalNode(this, goal);
	}
	
	@Override
	public void initialize(State state){
		leveledOff = false;
		nextSteps.clear();
		levels.reset();
		levels.incremenetLevel();
		super.initialize(state);
	}
	
	public int countLevels(){
		return levels.countLevels();
	}

	public int countLiteralsAtLevel(int level){
		return levels.countLiteralsAtLevel(level);
	}
	
	public int countStepsAtLevel(int level){
		return levels.countStepsAtLevel(level);
	}

	public Iterator<LiteralNode> getLiteralsAtLevel(int level){
		return levels.getLiteralsAtLevel(level);
	}
	
	public Iterator<StepNode> getStepsAtLevel(int level){
		return levels.getStepsAtLevel(level);
	}
	
	public boolean hasLeveledOff(){
		return leveledOff;
	}
	
	public boolean extend(){
		levels.incremenetLevel();
		int literalCount = countLiteralsAtLevel(countLevels() - 1);
		nextSteps.activateAll();
		if(countLiteralsAtLevel(countLevels() - 1) == literalCount)
			leveledOff = true;
		return leveledOff;
	}

	public void extendUnitlLeveledOff(){
		while(!extend());
	}
}
