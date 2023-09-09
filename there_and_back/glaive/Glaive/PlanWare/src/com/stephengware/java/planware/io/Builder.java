package com.stephengware.java.planware.io;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.util.ImmutableList;

public class Builder<D> implements Cloneable {

	private final class State {
		
		public final Universe universe;
		public final Domain domain;
		public final Problem problem;
		public final ImmutableList<Extension<?, D>> extensions;
		public final ImmutableList<Triplet<Class<?>, DocumentBuilder<?, D>, Boolean>> documentBuilders;
		
		private State(Universe universe,
				Domain domain,
				Problem problem,
				ImmutableList<Extension<?, D>> extensions,
				ImmutableList<Triplet<Class<?>, DocumentBuilder<?, D>, Boolean>> documentBuilders){
			this.universe = universe;
			this.domain = domain;
			this.problem = problem;
			this.extensions = extensions;
			this.documentBuilders = documentBuilders;
		}
		
		public State(){
			this(null,
					null,
					null,
					new ImmutableList<Extension<?, D>>(),
					new ImmutableList<Triplet<Class<?>, DocumentBuilder<?, D>, Boolean>>());
		}
		
		public State setUniverse(Universe universe){
			if(universe == null)
				return new State(null, null, null, extensions, documentBuilders);
			else if(this.universe != null && universe.subsumes(this.universe))
				return new State(universe, domain, problem, extensions, documentBuilders);
			else
				return new State(universe, null, null, extensions, documentBuilders);
		}
		
		public State setDomain(Domain domain){
			if(domain == null)
				return new State(universe, null, null, extensions, documentBuilders);
			else if(this.universe != null && this.universe.subsumes(domain.universe))
				return new State(universe, domain, null, extensions, documentBuilders);
			else
				return new State(domain.universe, domain, null, extensions, documentBuilders);
		}
		
		public State setProblem(Problem problem){
			if(problem == null)
				return new State(universe, domain, null, extensions, documentBuilders);
			else if(this.universe != null && this.universe.subsumes(problem.universe))
				return new State(universe, problem.domain, problem, extensions, documentBuilders);
			else
				return new State(problem.universe, problem.domain, problem, extensions, documentBuilders);
		}
		
		public State addExtension(Extension<?, D> extension){
			return new State(universe, domain, problem, extensions.add(extension), documentBuilders);
		}
		
		public State addDocumentBuilder(Class<?> objectType, DocumentBuilder<?, D> documentBuilder, boolean overrides){
			return new State(universe, domain, problem, extensions, documentBuilders.add(new Triplet<Class<?>, DocumentBuilder<?, D>, Boolean>(objectType, documentBuilder, overrides)));
		}
	}
	
	private State state;
	
	protected Builder(Builder<D> toClone){
		this.state = toClone.state;
	}
	
	protected Builder(){
		this.state = new State();
	}
	
	public Universe getUniverse(){
		return state.universe;
	}
	
	public void setUniverse(Universe universe){
		state = state.setUniverse(universe);
	}
	
	public Domain getDomain(){
		return state.domain;
	}
	
	public void setDomain(Domain domain){
		state = state.setDomain(domain);
	}
	
	public Problem getProblem(){
		return state.problem;
	}
	
	public void setProblem(Problem problem){
		state = state.setProblem(problem);
	}
	
	public void install(Extension<?, D> extension){
		state = state.addExtension(extension);
		extension.configure(this);
	}
	
	public Iterable<Extension<?, D>> getInstalledExtensions(){
		return state.extensions;
	}
	
	public boolean isInstalled(Extension<?, D> extension){
		for(Extension<?, D> e : state.extensions)
			if(e.equals(extension))
				return true;
		return false;
	}
	
	public void installOnce(Extension<?, D> extension){
		if(!isInstalled(extension))
			install(extension);
	}
	
	public void addDocumentBuilder(Class<?> objectType, DocumentBuilder<?, D> documentBuilder){
		state = state.addDocumentBuilder(objectType, documentBuilder, false);
	}
	
	public void overrideDocumentBuilder(Class<?> objectType, DocumentBuilder<?, D> documentBuilder){
		state = state.addDocumentBuilder(objectType, documentBuilder, true);
	}
	
	private final Triplet<Class<?>, DocumentBuilder<?, D>, Boolean> getNextDocumentBuilder(Class<?> objectType, Triplet<Class<?>, DocumentBuilder<?, D>, Boolean> current){
		Triplet<Class<?>, DocumentBuilder<?, D>, Boolean> previous = null;
		for(Triplet<Class<?>, DocumentBuilder<?, D>, Boolean> triplet : state.documentBuilders){
			if(triplet == current)
				return previous;
			if(triplet.first.isAssignableFrom(objectType)){
				if(triplet.third)
					return triplet;
				else
					previous = triplet;
			}
		}
		return previous;
	}
	
	@SuppressWarnings("unchecked")
	public <T> D build(T object) throws BuildException {
		State backup = state;
		try{
			D document = null;
			Triplet<Class<?>, DocumentBuilder<?, D>, Boolean> current = getNextDocumentBuilder(object.getClass(), null);
			while(current != null){
				document = ((DocumentBuilder<T, D>) current.second).build(object, document, this);
				current = getNextDocumentBuilder(object.getClass(), current);
			}
			if(document == null)
				throw new BuildException("Failed to convert the " + object.getClass().getSimpleName() + " \"" + object + "\" into a document.");
			return document;
		}
		finally{
			state = backup;
		}
	}
	
	@Override
	public Builder<D> clone(){
		return new Builder<D>(this);
	}
}
