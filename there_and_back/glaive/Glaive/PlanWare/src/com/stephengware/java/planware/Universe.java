package com.stephengware.java.planware;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Set;

import com.stephengware.java.planware.logic.Constant;
import com.stephengware.java.planware.logic.Entity;
import com.stephengware.java.planware.logic.Expression;
import com.stephengware.java.planware.logic.ExpressionVariable;
import com.stephengware.java.planware.logic.ModalExpression;
import com.stephengware.java.planware.logic.Predication;
import com.stephengware.java.planware.logic.QuantifiedExpression;
import com.stephengware.java.planware.logic.Substitution;
import com.stephengware.java.planware.logic.SubstitutionObject;
import com.stephengware.java.planware.logic.Taxonomy;
import com.stephengware.java.planware.logic.TermVariable;
import com.stephengware.java.planware.logic.Type;
import com.stephengware.java.planware.util.ImmutableSet;

public class Universe extends SubstitutionObject {

	public final Taxonomy taxonomy;
	public final ImmutableSet<Constant> objects;
	public final ImmutableSet<Predication> predicates;
	public final ImmutableSet<ModalExpression> modalities;
	private final int hashCode;
	
	protected final HashMap<Type, ImmutableSet<Constant>> objectsByType = new HashMap<>();
	
	public Universe(Taxonomy taxonomy, ImmutableSet<Constant> objects, ImmutableSet<Predication> predicates, ImmutableSet<ModalExpression> modalities){
		// Taxonomy
		if(taxonomy == null)
			taxonomy = Taxonomy.EMPTY;
		this.taxonomy = taxonomy;
		// Objects
		if(objects == null)
			this.objects = new ImmutableSet<Constant>(new Constant[0]);
		else{
			this.objects = objects;
			for(int i=0; i<objects.length; i++)
				if(objects.get(i) == null)
					throw new FormatException("universe", "Object " + (i + 1) + " is null.");
		}
		for(Type type : taxonomy.getTypes()){
			LinkedList<Constant> objectsOfType = new LinkedList<>();
			for(Constant object : this.objects)
				if(taxonomy.hasRelationship(type, object.getType()))
					objectsOfType.add(object);
			objectsByType.put(type, new ImmutableSet<Constant>(objectsOfType.toArray(new Constant[0])));
		}
		// Predicates
		if(predicates == null)
			this.predicates = new ImmutableSet<Predication>(new Predication[0]);
		else{
			this.predicates = predicates;
			for(int i=0; i<predicates.length; i++)
				if(predicates.get(i) == null)
					throw new FormatException("universe", "Predicate " + (i + 1) + " is null.");
		}
		// Modalities
		if(modalities == null)
			this.modalities = new ImmutableSet<ModalExpression>(new ModalExpression[0]);
		else{
			this.modalities = modalities;
			for(int i=0; i<modalities.length; i++)
				if(modalities.get(i) == null)
					throw new FormatException("universe", "Modality " + (i + 1) + " is null.");
		}
		// Hash Code
		int hc = 1;
		hc = 31 * hc + this.taxonomy.hashCode();
		hc = 31 * hc + this.objects.hashCode();
		hc = 31 * hc + this.predicates.hashCode();
		hc = 31 * hc + this.modalities.hashCode();
		this.hashCode = hc;
	}
	
	public Universe(Taxonomy taxonomy, Constant[] objects, Predication[] predicates, ModalExpression[] modalities){
		this(taxonomy, new ImmutableSet<Constant>(objects), new ImmutableSet<Predication>(predicates), new ImmutableSet<ModalExpression>(modalities));
	}
	
	public Universe(Taxonomy taxonomy, Set<Constant> objects, Set<Predication> predicates, Set<ModalExpression> modalities){
		this(taxonomy, objects.toArray(new Constant[objects.size()]), predicates.toArray(new Predication[predicates.size()]), modalities.toArray(new ModalExpression[modalities.size()]));
	}
		
	@Override
	public int hashCode(){
		return hashCode;
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Universe){
			Universe otherUniverse = (Universe) other;
			if(!testCompatibility(otherUniverse) || !otherUniverse.testCompatibility(this))
				return false;
			return taxonomy.equals(otherUniverse.taxonomy) &&
				objects.equals(otherUniverse.objects) &&
				predicates.equals(otherUniverse.predicates) &&
				modalities.equals(otherUniverse.modalities);
		}
		return false;
	}
	
	protected boolean testCompatibility(Universe other){
		return true;
	}
	
	public final <E extends Entity> Set<E> collect(Class<E> entityType){
		HashSet<E> collection = new HashSet<E>();
		collect(entityType, collection);
		return collection;	
	}
	
	public <E extends Entity> void collect(Class<E> entityType, Collection<E> collection){
		for(Constant object : objects)
			object.collect(entityType, collection);
		for(Predication predicate : predicates)
			predicate.collect(entityType, collection);
		for(ModalExpression modality : modalities)
			modality.collect(entityType, collection);
	}
	
	public Universe substitute(Substitution substitution){
		boolean different = false;
		HashSet<Constant> substitutedObjects = new HashSet<>();
		for(Constant object : objects){
			Constant substitutedObject = substitution.substitute(object, Constant.class);
			if(object != substitutedObject)
				different = true;
			substitutedObjects.add(substitutedObject);
		}
		HashSet<Predication> substitutedPredicates = new HashSet<>();
		for(Predication predicate : predicates){
			Predication substitutedPredicate = substitution.substitute(predicate, Predication.class);
			if(predicate != substitutedPredicate)
				different = true;
			substitutedPredicates.add(substitutedPredicate);
		}
		HashSet<ModalExpression> substitutedModalities = new HashSet<>();
		for(ModalExpression modality : modalities){
			ModalExpression substitutedModality = substitution.substitute(modality, ModalExpression.class);
			if(modality != substitutedModality)
				different = true;
			substitutedModalities.add(substitutedModality);
		}
		if(different)
			return new Universe(taxonomy, substitutedObjects, substitutedPredicates, substitutedModalities);
		else
			return this;
	}
	
	public boolean subsumes(Universe other){
		for(Type type : other.taxonomy.getTypes())
			if(!defines(type))
				return false;
		for(Constant object : other.objects)
			if(!defines(object))
				return false;
		for(Predication predicate : other.predicates)
			if(!defines(predicate))
				return false;
		for(ModalExpression modality : other.modalities)
			if(!defines(modality))
				return false;
		return true;
	}
	
	private static final ImmutableSet<Constant> NO_CONSTANTS = new ImmutableSet<Constant>(new Constant[0]);
	
	public ImmutableSet<Constant> getObjectsByType(Type type){
		ImmutableSet<Constant> constants = objectsByType.get(type);
		if(constants == null)
			return NO_CONSTANTS;
		else
			return constants;
	}

	public boolean defines(Object object){
		return getUndefinedObject(object) == null;
	}

	public Object getUndefinedObject(Object object){
		if(object instanceof Entity){
			if(object instanceof Constant){
				Constant constant = (Constant) object;
				for(Constant obj : objects)
					if(constant.equals(obj))
						return null;
				return constant;
			}
			else if(object instanceof TermVariable)
				return getUndefinedObject(((TermVariable) object).type);
			else if(object instanceof ExpressionVariable){
				ExpressionVariable expVar = (ExpressionVariable) object;
				for(Expression expression : collect(Expression.class))
					if(expVar.subsumes(expression, taxonomy))
						return null;
				return expVar;
			}
			else if(object instanceof Predication){
				Predication predication = (Predication) object;
				for(Predication predicate : predicates)
					if(predicate.subsumes(predication, taxonomy))
						return null;
				return predication;
			}
			else if(object instanceof ModalExpression){
				ModalExpression modal = (ModalExpression) object;
				for(ModalExpression modality : modalities)
					if(modality.subsumes(modal, taxonomy))
						return null;
				return modal;
			}
			else{
				Iterator<? extends Entity> iterator = ((Entity) object).iterator();
				if(iterator.hasNext()){
					Object undefined = getUndefinedObject(iterator.next());
					if(undefined != null)
						return undefined;
				}
				return null;
			}
		}
		else if(object instanceof Type){
			if(taxonomy.definesType((Type) object))
				return null;
			else
				return object;
		}
		else if(object instanceof Operator){
			for(Entity entity : ((Operator) object).collect(Entity.class)){
				Object undefined = getUndefinedObject(entity);
				if(undefined != null)
					return undefined;
			}
			return null;
		}
		else if(object instanceof Step){
			for(Entity entity : ((Step) object).collect(Entity.class)){
				Object undefined = getUndefinedObject(entity);
				if(undefined != null)
					return undefined;
			}
			return null;
		}
		else if(object instanceof AxiomTemplate){
			for(Entity entity : ((AxiomTemplate) object).collect(Entity.class)){
				Object undefined = getUndefinedObject(entity);
				if(undefined != null)
					return undefined;
			}
			return null;
		}
		else if(object instanceof Axiom){
			for(Entity entity : ((Axiom) object).collect(Entity.class)){
				Object undefined = getUndefinedObject(entity);
				if(undefined != null)
					return undefined;
			}
			return null;
		}
		else
			return object;
	}
	
	@Override
	protected Entity substitute(Entity entity){
		if(entity instanceof QuantifiedExpression)
			return ((QuantifiedExpression) entity).toUniversalBase(this);
		else
			return entity;
	}
	
	@Override
	public String toString(){
		return "[Universe: " + taxonomy.countTypes() + " types, " + objects.length + " objects, " + predicates.length + " predicates, " + modalities.length + " modalities]";
	}
}
