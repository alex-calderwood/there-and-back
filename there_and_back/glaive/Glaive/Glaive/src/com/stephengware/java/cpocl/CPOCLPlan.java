package com.stephengware.java.cpocl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import com.stephengware.java.planware.IntentionalProblem;
import com.stephengware.java.planware.IntentionalStep;
import com.stephengware.java.planware.Plan;
import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.Literal;
import com.stephengware.java.planware.util.DirectedAcyclicGraph;
import com.stephengware.java.planware.util.Edge;
import com.stephengware.java.planware.util.ImmutableSet;

public class CPOCLPlan extends Plan {

	private final CPOCLStep startStep;
	private final CPOCLStep endStep;
	private final ArrayList<CPOCLStep> steps;
	private final DirectedAcyclicGraph<CPOCLStep> orderings;
	private final ArrayList<CausalLink> links;
	private final ArrayList<IntentionFrame> frames;
	
	protected CPOCLPlan(CPOCLPlan toClone){
		super(toClone.name, toClone.problem);
		HashMap<CPOCLStep, Integer> id = new HashMap<>();
		this.startStep = new CPOCLStep(0, "start", Expression.TRUE, problem.getInitialState(), NO_AGENTS, true);
		this.endStep = new CPOCLStep(toClone.countSteps() - 1, "end", problem.getGoal(), Expression.TRUE, NO_AGENTS, true);
		id.put(toClone.getStartStep(), this.startStep.index);
		id.put(toClone.getEndStep(), this.endStep.index);
		this.steps = new ArrayList<>();
		this.orderings = new DirectedAcyclicGraph<>();
		this.steps.add(this.startStep);
		for(CPOCLStep step : toClone.steps()){
			if(step != toClone.getStartStep() && step != toClone.getEndStep()){
				CPOCLStep s = addStep(step, step.executed);
				id.put(step, s.index);
			}
		}
		this.steps.add(this.endStep);
		for(Ordering ordering : toClone.orderings())
			addOrdering(id.get(ordering.before), id.get(ordering.after));
		this.links = new ArrayList<>();
		for(CausalLink link : toClone.causalLinks())
			addCausalLink(id.get(link.tail), link.label, id.get(link.head));
		this.frames = new ArrayList<>();
		for(IntentionFrame frame : toClone.frames){
			int motivations[] = new int[frame.motivations.length];
			for(int i=0; i<motivations.length; i++)
				motivations[i] = id.get(frame.motivations.get(i));
			IntentionFrame f = addIntentionFrame(frame.agent, frame.goal, motivations);
			for(CPOCLStep step : frame.steps())
				f.addStep(id.get(step));
		}
	}
	
	private static final ImmutableSet<Constant> NO_AGENTS = new ImmutableSet<Constant>(new Constant[0]);
	
	public CPOCLPlan(String name, IntentionalProblem problem){
		super(name, problem);
		this.startStep = new CPOCLStep(0, "start", Expression.TRUE, problem.getInitialState(), NO_AGENTS, true);
		this.endStep = new CPOCLStep(1, "end", problem.getGoal(), Expression.TRUE, NO_AGENTS, true);
		this.steps = new ArrayList<>();
		this.orderings = new DirectedAcyclicGraph<>();
		this.links = new ArrayList<>();
		this.frames = new ArrayList<>();
		this.steps.add(startStep);
		this.steps.add(endStep);
		orderings.addEdge(startStep, endStep);
	}

	@Override
	public int countSteps(){
		return steps.size();
	}
	
	public CPOCLStep addStep(IntentionalStep step, boolean executed){
		CPOCLStep s = new CPOCLStep(steps.size(), step, executed);
		steps.add(s);
		orderings.addEdge(getStartStep(), s);
		orderings.addEdge(s, getEndStep());
		return s;
	}
	
	public CPOCLStep getStartStep(){
		return startStep;
	}
	
	public CPOCLStep getEndStep(){
		return endStep;
	}
	
	public CPOCLStep getStep(int index){
		return steps.get(index);
	}

	@Override
	public Iterable<? extends CPOCLStep> steps(){
		return orderings.sort();
	}
	
	public int countOrderings(){
		return orderings.countEdges();
	}
	
	public boolean canAddOrdering(int before, int after){
		CPOCLStep beforeStep = getStep(before);
		CPOCLStep afterStep = getStep(after);
		return !orderings.path(afterStep, beforeStep);
	}
	
	public Ordering addOrdering(int before, int after){
		CPOCLStep beforeStep = getStep(before);
		CPOCLStep afterStep = getStep(after);
		orderings.addEdge(beforeStep, afterStep);
		return new Ordering(beforeStep, afterStep);
	}
	
	private final class OrderingIterator implements Iterator<Ordering> {

		private final Iterator<Edge<CPOCLStep>> edges = orderings.edges().iterator();
		
		@Override
		public boolean hasNext(){
			return edges.hasNext();
		}

		@Override
		public Ordering next(){
			Edge<CPOCLStep> edge = edges.next();
			return new Ordering(edge.tail, edge.head);
		}

		@Override
		public void remove(){
			edges.remove();
		} 
	}
	
	private final Iterable<Ordering> orderingsIterable = new Iterable<Ordering>(){

		@Override
		public Iterator<Ordering> iterator(){
			return new OrderingIterator();
		}
	};
	
	public Iterable<Ordering> orderings(){
		return orderingsIterable;
	}
	
	public int countCausalLinks(){
		return links.size();
	}
	
	public CausalLink addCausalLink(int tail, Literal label, int head){
		CausalLink link = new CausalLink(getStep(tail), label, getStep(head));
		links.add(link);
		addOrdering(tail, head);
		return link;
	}
	
	public Iterable<CausalLink> causalLinks(){
		return links;
	}
	
	public int countIntentionFrames(){
		return frames.size();
	}
	
	public IntentionFrame addIntentionFrame(Constant agent, Expression goal, int...motivations){
		CPOCLStep[] m = new CPOCLStep[motivations.length];
		for(int i=0; i<motivations.length; i++)
			m[i] = getStep(motivations[i]);
		IntentionFrame frame = new IntentionFrame(this, agent, goal, m);
		frames.add(frame);
		return frame;
	}
	
	public Iterable<IntentionFrame> intentionFrames(){
		return frames;
	}

	@Override
	public Plan clone(){
		return new CPOCLPlan(this);
	}
	
	@Override
	public String toString(){
		return "[Plan: " + countSteps() + " steps " + countCausalLinks() + " links " + countIntentionFrames() + " frames]";
	}
}
