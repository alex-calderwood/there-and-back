package com.stephengware.java.planware;

import java.io.File;
import java.io.IOException;

import com.stephengware.java.planware.io.IOManager;
import com.stephengware.java.planware.io.ParseException;

public abstract class Argument<T> {

	public final String name;
	public final String abbreviation;
	
	public Argument(String name, String abbreviation){
		this.name = name;
		this.abbreviation = abbreviation;
	}
	
	public Argument(String name){
		this(name, null);
	}
	
	@Override
	public int hashCode(){
		return name.hashCode();
	}
	
	@Override
	public boolean equals(Object other){
		if(this == other)
			return true;
		else if(other instanceof Argument<?>)
			return name.equals(((Argument<?>) other).name);
		else
			return false;
	}
	
	protected abstract T getValue(Object object, ArgumentMap arguments);
	
	public static class SimpleArgument<T> extends Argument<T> {

		public final Class<T> objectType;
		
		public SimpleArgument(String name, String abbreviation, Class<T> objectType){
			super(name, abbreviation);
			this.objectType = objectType;
		}
		
		public SimpleArgument(String name, Class<T> objectType){
			super(name);
			this.objectType = objectType;
		}

		@Override
		protected T getValue(Object object, ArgumentMap arguments){
			return objectType.cast(object);
		}
	}
	
	public static class BooleanArgument extends Argument<Boolean> {

		private final boolean defaulValue;
		
		public BooleanArgument(String name, String abbreviation, boolean defaultValue){
			super(name, abbreviation);
			this.defaulValue = defaultValue;
		}
		
		public BooleanArgument(String name, boolean defaultValue){
			super(name);
			this.defaulValue = defaultValue;
		}

		@Override
		protected Boolean getValue(Object object, ArgumentMap arguments){
			if(object == null)
				return defaulValue;
			else if(object instanceof String){
				Boolean value = Boolean.parseBoolean((String) object);
				arguments.set(this, value);
				return value;
			}
			else
				return (Boolean) object;
		}
	}
	
	public static class IntegerArgument extends Argument<Integer> {

		private final int defaulValue;
		
		public IntegerArgument(String name, String abbreviation, int defaultValue){
			super(name, abbreviation);
			this.defaulValue = defaultValue;
		}
		
		public IntegerArgument(String name, int defaultValue){
			super(name);
			this.defaulValue = defaultValue;
		}

		@Override
		protected Integer getValue(Object object, ArgumentMap arguments){
			if(object == null)
				return defaulValue;
			else if(object instanceof String){
				Integer value = Integer.parseInt((String) object);
				arguments.set(this, value);
				return value;
			}
			else
				return (Integer) object;
		}
	}
	
	public static class FileArgument extends Argument<File> {

		public FileArgument(String name, String abbreviation){
			super(name, abbreviation);
		}
		
		public FileArgument(String name){
			super(name);
		}

		@Override
		protected File getValue(Object object, ArgumentMap arguments){
			if(object instanceof File)
				return (File) object;
			else
				return new File((String) object);
		}
	}
	
	public static class ParsedArgument<T> extends Argument<T> {

		public final Class<T> objectType;
		
		public ParsedArgument(String name, String abbreviation, Class<T> objectType){
			super(name, abbreviation);
			this.objectType = objectType;
		}
		
		public ParsedArgument(String name, Class<T> objectType){
			super(name);
			this.objectType = objectType;
		}

		@Override
		protected T getValue(Object object, ArgumentMap arguments){
			if(objectType.isAssignableFrom(object.getClass()))
				return objectType.cast(object);
			IOManager<?, ?> ioManager = arguments.get(Planner.IO_MANAGER);
			try{
				File file = new File((String) object);
				T value = parse(ioManager, file);
				arguments.set(this, value);
				return value;
			}
			catch(IOException | ParseException ex){
				throw new RuntimeException(ex);
			}
		}
		
		protected T parse(IOManager<?, ?> ioManager, File file) throws IOException, ParseException {
			return ioManager.read(file, objectType);
		}
	}
}
