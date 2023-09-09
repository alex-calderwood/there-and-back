package com.stephengware.java.planware.io;

import java.util.LinkedHashMap;
import java.util.Map;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.FormatException;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.util.ImmutableList;

public class Parser<D> implements Cloneable {

	private final class State {
		
		public final Universe universe;
		public final Domain domain;
		public final Problem problem;
		public final ImmutableList<Extension<D, ?>> extensions;
		public final ImmutableList<String> keywords;
		public final ImmutableList<Triplet<Class<?>, DocumentParser<D>, Boolean>> documentParsers;
		public final ImmutableList<Pair<String, Object>> definedObjects;
		public final ImmutableList<Pair<Field<?, ?>, Object>> definedFields;
		
		private State(Universe universe,
				Domain domain,
				Problem problem,
				ImmutableList<Extension<D, ?>> extensions,
				ImmutableList<String> keywords,
				ImmutableList<Triplet<Class<?>,
				DocumentParser<D>, Boolean>> documentParsers,
				ImmutableList<Pair<String, Object>> definedObjects,
				ImmutableList<Pair<Field<?, ?>, Object>> definedFields){
			this.universe = universe;
			this.domain = domain;
			this.problem = problem;
			this.extensions = extensions;
			this.keywords = keywords;
			this.documentParsers = documentParsers;
			this.definedObjects = definedObjects;
			this.definedFields = definedFields;
		}
		
		public State(){
			this(null,
					null,
					null,
					new ImmutableList<Extension<D, ?>>(),
					new ImmutableList<String>(),
					new ImmutableList<Triplet<Class<?>, DocumentParser<D>, Boolean>>(),
					new ImmutableList<Pair<String, Object>>(),
					new ImmutableList<Pair<Field<?, ?>, Object>>());
		}
		
		public State setUniverse(Universe universe){
			if(universe == null)
				return new State(null, null, null, extensions, keywords, documentParsers, definedObjects, definedFields);
			else if(this.universe != null && universe.subsumes(this.universe))
				return new State(universe, domain, problem, extensions, keywords, documentParsers, definedObjects, definedFields);
			else
				return new State(universe, null, null, extensions, keywords, documentParsers, definedObjects, definedFields);
		}
		
		public State setDomain(Domain domain){
			if(domain == null)
				return new State(universe, null, null, extensions, keywords, documentParsers, definedObjects, definedFields);
			else if(this.universe != null && this.universe.subsumes(domain.universe))
				return new State(universe, domain, null, extensions, keywords, documentParsers, definedObjects, definedFields);
			else
				return new State(domain.universe, domain, null, extensions, keywords, documentParsers, definedObjects, definedFields);
		}
		
		public State setProblem(Problem problem){
			if(problem == null)
				return new State(universe, domain, null, extensions, keywords, documentParsers, definedObjects, definedFields);
			else if(this.universe != null && this.universe.subsumes(problem.universe))
				return new State(universe, problem.domain, problem, extensions, keywords, documentParsers, definedObjects, definedFields);
			else
				return new State(problem.universe, problem.domain, problem, extensions, keywords, documentParsers, definedObjects, definedFields);
		}
		
		public State addExtension(Extension<D, ?> extension){
			return new State(universe, domain, problem, extensions.add(extension), keywords, documentParsers, definedObjects, definedFields);
		}
		
		public State addKeyword(String keyword){
			return new State(universe, domain, problem, extensions, keywords.add(keyword), documentParsers, definedObjects, definedFields);
		}
		
		public State addDocumentParser(Class<?> objectType, DocumentParser<D> documentParser, boolean overrides){
			return new State(universe, domain, problem, extensions, keywords, documentParsers.add(new Triplet<Class<?>, DocumentParser<D>, Boolean>(objectType, documentParser, overrides)), definedObjects, definedFields);
		}
		
		public State addDefinedObject(String name, Object object){
			return new State(universe, domain, problem, extensions, keywords, documentParsers, definedObjects.add(new Pair<String, Object>(name, object)), definedFields);
		}
		
		public State addDefinedField(Field<?, ?> field, Object value){
			return new State(universe, domain, problem, extensions, keywords, documentParsers, definedObjects, definedFields.add(new Pair<Field<?, ?>, Object>(field, value)));
		}
	}
	
	private final IOManager<D, ?> manager;
	private final SubtypeTracker subtypeTracker;
	private State state;
	
	protected Parser(Parser<D> toClone){
		this.manager = toClone.manager;
		this.subtypeTracker = toClone.subtypeTracker;
		this.state = toClone.state;
	}
	
	protected Parser(IOManager<D, ?> manager){
		this.manager = manager;
		this.subtypeTracker = new SubtypeTracker();
		this.state = new State();
	}
	
	public Universe getUniverse(){
		return state.universe;
	}
	
	public Universe requireUniverse() throws ParseException {
		if(state.universe == null)
			throw new ParseException("No universe is defined.");
		return state.universe;
	}
	
	public void setUniverse(Universe universe){
		state = state.setUniverse(universe);
	}
	
	public Domain getDomain(){
		return state.domain;
	}
	
	public Domain requireDomain() throws ParseException {
		if(state.domain == null)
			throw new ParseException("No domain is defined.");
		return state.domain;
	}
	
	public void setDomain(Domain domain){
		state = state.setDomain(domain);
	}
	
	public Problem getProblem(){
		return state.problem;
	}
	
	public Problem requireProblem() throws ParseException {
		if(state.problem == null)
			throw new ParseException("No problem is defined.");
		return state.problem;
	}
	
	public void setProblem(Problem problem){
		state = state.setProblem(problem);
	}
	
	public void install(Extension<D, ?> extension){
		state = state.addExtension(extension);
		extension.configure(this);
	}
	
	public Iterable<Extension<D, ?>> getInstalledExtensions(){
		return state.extensions;
	}
	
	public boolean isInstalled(Extension<D, ?> extension){
		for(Extension<D, ?> e : state.extensions)
			if(e.equals(extension))
				return true;
		return false;
	}
	
	public void installOnce(Extension<D, ?> extension){
		if(!isInstalled(extension))
			install(extension);
	}
	
	public void addReservedKeyword(String keyword){
		state = state.addKeyword(keyword);
	}
	
	public boolean isReservedKeyword(String string){
		for(String keyword : state.keywords)
			if(keyword.equals(string))
				return true;
		return false;
	}
	
	public void addDocumentParser(Class<?> objectType, DocumentParser<D> documentParser){
		state = state.addDocumentParser(objectType, documentParser, false);
		subtypeTracker.add(objectType);
	}
	
	public void overrideDocumentParser(Class<?> objectType, DocumentParser<D> documentParser){
		state = state.addDocumentParser(objectType, documentParser, true);
		subtypeTracker.add(objectType);
	}
	
	private final Triplet<Class<?>, DocumentParser<D>, Boolean> getNextDocumentParser(Class<?> objectType, Triplet<Class<?>, DocumentParser<D>, Boolean> current){
		Triplet<Class<?>, DocumentParser<D>, Boolean> previous = null;
		for(Triplet<Class<?>, DocumentParser<D>, Boolean> triplet : state.documentParsers){
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
	
	public void defineObject(String name, Object object){
		state = state.addDefinedObject(name, object);
	}
	
	@SuppressWarnings("unchecked")
	public <T> T getDefinedObject(String name, Class<T> objectType){
		for(Pair<String, Object> pair : state.definedObjects)
			if(pair.first.equals(name) && objectType.isAssignableFrom(pair.second.getClass()))
				return (T) pair.second;
		return null;
	}
	
	public <T> T requireDefinedObject(String name, Class<T> objectType) throws ParseException {
		T object = getDefinedObject(name, objectType);
		if(object == null)
			throw new ParseException("The parser expected " + objectType.getSimpleName() + " \"" + name + "\" to be defined, but no such object was found.");
		return object;
	}
	
	@SuppressWarnings("unchecked")
	public <T> Map<String, T> getDefinedObjects(Class<T> objectType){
		LinkedHashMap<String, T> map = new LinkedHashMap<>();
		for(Pair<String, Object> pair : state.definedObjects){
			if(objectType.isAssignableFrom(pair.second.getClass())){
				if(!map.containsKey(pair.first))
					map.put(pair.first, (T) pair.second);
			}
		}
		return map;
	}
	
	public <F> void define(Field<?, F> field, F value){
		state = state.addDefinedField(field, value);
	}
	
	@SuppressWarnings("unchecked")
	public <F> F get(Field<?, F> field){
		for(Pair<Field<?, ?>, Object> pair : state.definedFields)
			if(pair.first.equals(field))
				return (F) pair.second;
		return null;
	}
	
	public <F> F require(Field<?, F> field) throws ParseException {
		F value = get(field);
		if(value == null)
			throw new ParseException("The parser expected " + field + " to be defined, but no such field was found.");
		return value;
	}
	
	@SuppressWarnings("unchecked")
	public <T> T parse(D document, Class<T> objectType) throws ParseException {
		State backup = state;
		T object = null;
		for(Class<? extends T> subtype : subtypeTracker.getKnownSubtypes(objectType)){
			object = parse(document, subtype);
			if(object != null)
				return object;
		}
		try{
			Triplet<Class<?>, DocumentParser<D>, Boolean> current = getNextDocumentParser(objectType, null);
			while(current != null){
				try{
					if(current.third)
						state = backup;
					current.second.parse(document, this);
				}
				catch(SuccessAction success){
					if(objectType.isAssignableFrom(success.object.getClass()))
						object = (T) success.object;
				}
				catch(FailureAction fail){
					object = null;
					break;
				}
				catch(ParseException ex){
					addDetails(ex);
					throw ex;
				}
				catch(FormatException ex){
					ParseException parseException = new ParseException(document, ex.getMessage());
					addDetails(parseException);
					throw parseException;
				}
				current = getNextDocumentParser(objectType, current);
			}
			return object;
		}
		finally{
			state = backup;
		}
	}
	
	public <T> T parseOrFail(D document, Class<T> objectType) throws ParseException {
		T object = parse(document, objectType);
		if(object == null){
			ParseException ex = new ParseException(document, objectType);
			addDetails(ex);
			throw ex;
		}
		else
			return object;
	}
	
	@SuppressWarnings("unchecked")
	private final void addDetails(ParseException exception){
		if(exception.document == null)
			return;
		if(exception.lineNumber < 1)
			exception.lineNumber = manager.documentReader.getLineNumber((D) exception.document);
		if(exception.characterNumber < 1)
			exception.characterNumber = manager.documentReader.getCharacterNumber((D) exception.document);
	}
	
	@Override
	public Parser<D> clone(){
		return new Parser<D>(this);
	}
}
