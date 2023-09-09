package com.stephengware.java.planware.io.pddl.cpocl;

import com.stephengware.java.cpocl.CPOCLPlan;
import com.stephengware.java.cpocl.CPOCLStep;
import com.stephengware.java.cpocl.CausalLink;
import com.stephengware.java.cpocl.IntentionFrame;
import com.stephengware.java.cpocl.Ordering;
import com.stephengware.java.planware.io.BuildException;
import com.stephengware.java.planware.io.Builder;
import com.stephengware.java.planware.io.DocumentBuilder;
import com.stephengware.java.planware.io.Extension;
import com.stephengware.java.planware.io.Parser;
import com.stephengware.java.planware.io.pddl.sexp.FormatRule;
import com.stephengware.java.planware.io.pddl.sexp.List;
import com.stephengware.java.planware.io.pddl.sexp.SExpression;

public class CPOCLPlanExtension implements Extension<SExpression, SExpression>, DocumentBuilder<CPOCLPlan, SExpression> {

	@Override
	public void configure(Parser<SExpression> parser){}

	@Override
	public void configure(Builder<SExpression> builder){
		builder.overrideDocumentBuilder(CPOCLPlan.class, this);
	}

	@Override
	public SExpression build(CPOCLPlan plan, SExpression document, Builder<SExpression> builder) throws BuildException {
		document = new List("define", new List("plan", plan.name), new List(":problem", plan.problem.name));
		((List) document).setFormatRule(FormatRule.PDDL_DOCUMENT);
		buildSteps(plan, (List) document, builder);
		buildOrderings(plan, (List) document, builder);
		buildCausalLinks(plan, (List) document, builder);
		buildIntentionFrames(plan, (List) document, builder);
		return document;
	}
	
	protected void buildSteps(CPOCLPlan plan, List document, Builder<SExpression> builder) throws BuildException {
		List stepsList = new List(":steps");
		stepsList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(int i=0; i<plan.countSteps(); i++){
			CPOCLStep step = plan.getStep(i);
			if(step.executed)
				stepsList.addChild(builder.build(step));
			else
				stepsList.addChild(new List("non-executed", builder.build(step)));
		}
		document.addChild(stepsList);
	}
	
	protected void buildOrderings(CPOCLPlan plan, List document, Builder<SExpression> builder) throws BuildException {
		List orderingsList = new List(":orderings");
		orderingsList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(Ordering ordering : plan.orderings())
			orderingsList.addChild(new List(ordering.before.index, ordering.after.index));
		document.addChild(orderingsList);
	}
	
	protected void buildCausalLinks(CPOCLPlan plan, List document, Builder<SExpression> builder) throws BuildException {
		List clList = new List(":causal-links");
		clList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(CausalLink link : plan.causalLinks())
			clList.addChild(new List(link.tail.index, builder.build(link.label), link.head.index));
		document.addChild(clList);
	}
	
	protected void buildIntentionFrames(CPOCLPlan plan, List document, Builder<SExpression> builder) throws BuildException {
		List ifList = new List(":intention-frames");
		ifList.setFormatRule(FormatRule.TWO_ELEMENTS_ON_FIRST_LINE_THEN_ONE_PER_LINE);
		for(IntentionFrame frame : plan.intentionFrames()){
			List frameList = new List(":frame", ":agent", builder.build(frame.agent), ":goal", builder.build(frame.goal));
			List motivationsList = new List();
			for(CPOCLStep step : frame.motivations)
				motivationsList.addChild(Integer.toString(step.index));
			frameList.addChild(":motivations");
			frameList.addChild(motivationsList);
			List stepsList = new List();
			for(CPOCLStep step : frame.steps())
				stepsList.addChild(Integer.toString(step.index));
			if(!stepsList.isList(0)){
				frameList.addChild(":steps");
				frameList.addChild(stepsList);
			}
			frameList.setFormatRule(FormatRule.KEYWORD_ON_NEW_LINE);
			ifList.addChild(frameList);
		}
		document.addChild(ifList);
	}
}
