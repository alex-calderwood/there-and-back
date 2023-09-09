package com.stephengware.java.planware.io.pddl;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.util.ArrayIterable;

public class RequirementGroup extends Requirement {

	private final Requirement[] requirements;
	
	public RequirementGroup(String name, String description, Requirement...requirements){
		super(name, description);
		this.requirements = requirements;
	}

	@Override
	public Iterable<Requirement> getPrerequisites(){
		return new ArrayIterable<Requirement>(requirements);
	}

	@Override
	public boolean isRequiredBy(Domain domain){
		for(Requirement requirement : requirements)
			if(!requirement.isRequiredBy(domain))
				return false;
		return true;
	}

	@Override
	public boolean isRequiredBy(Problem problem){
		for(Requirement requirement : requirements)
			if(!requirement.isRequiredBy(problem))
				return false;
		return true;
	}
}
