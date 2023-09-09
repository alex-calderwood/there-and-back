package com.stephengware.java.planware.io;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.io.Writer;

import com.stephengware.java.planware.Domain;
import com.stephengware.java.planware.Problem;
import com.stephengware.java.planware.Universe;
import com.stephengware.java.planware.util.StringWriter;

public class IOManager<I, O> {

	final DocumentReader<I> documentReader;
	protected final Parser<I> parser;
	protected final Builder<O> builder;
	protected final DocumentWriter<O> documentWriter;
	
	protected IOManager(DocumentReader<I> documentReader, Parser<I> parser, Builder<O> builder, DocumentWriter<O> documentWriter){
		this.documentReader = documentReader;
		this.parser = parser;
		this.builder = builder;
		this.documentWriter = documentWriter;
	}
	
	public IOManager(DocumentReader<I> documentReader, DocumentWriter<O> documentWriter){
		this.documentReader = documentReader;
		this.parser = new Parser<I>(this);
		this.builder = new Builder<O>();
		this.documentWriter = documentWriter;
	}
	
	public void install(Extension<I, O> extension){
		installInputExtension(extension);
		installOutputExtension(extension);
	}
	
	public void installInputExtension(Extension<I, ?> extension){
		parser.installOnce(extension);
	}
	
	public void installOutputExtension(Extension<?, O> extension){
		builder.installOnce(extension);
	}
	
	public Universe getUniverse(){
		return parser.getUniverse();
	}
	
	public void setUniverse(Universe universe){
		parser.setUniverse(universe);
		builder.setUniverse(universe);
	}
	
	public Domain getDomain(){
		return parser.getDomain();
	}
	
	public void setDomain(Domain domain){
		if(parser.getDefinedObject(domain.name, Domain.class) != domain)
			parser.defineObject(domain.name, domain);
		parser.setDomain(domain);
		builder.setDomain(domain);
	}
	
	public Problem getProblem(){
		return parser.getProblem();
	}
	
	public void setProblem(Problem problem){
		if(parser.getDefinedObject(problem.name, Problem.class) != problem)
			parser.defineObject(problem.name, problem);
		parser.setProblem(problem);
		builder.setProblem(problem);
	}
	
	public <T> T read(Reader reader, Class<T> objectType) throws IOException, ParseException {
		T object = parser.parseOrFail(this.documentReader.read(reader), objectType);
		if(object instanceof Domain)
			parser.defineObject(((Domain) object).name, object);
		if(object instanceof Problem)
			parser.defineObject(((Problem) object).name, object);
		return object;
	}
	
	public <T> T read(String string, Class<T> objectType) throws IOException, ParseException {
		return read(new StringReader(string), objectType);
	}
	
	public <T> T read(File file, Class<T> objectType) throws IOException, ParseException {
		Reader reader = null;
		try{
			reader = new BufferedReader(new FileReader(file));
			T object = read(reader, objectType);
			return object;
		}
		finally{
			if(reader != null)
				reader.close();
		}
	}
	
	public void write(Object object, Writer writer) throws IOException, BuildException {
		documentWriter.write(builder.build(object), writer);
	}
	
	public String toString(Object object) throws IOException, BuildException {
		StringWriter stringWriter = new StringWriter();
		write(object, stringWriter);
		return stringWriter.toString();
	}
	
	public void write(Object object, File file) throws IOException, BuildException {
		Writer writer = null;
		try{
			writer = new BufferedWriter(new FileWriter(file));
			write(object, writer);
		}
		finally{
			if(writer != null)
				writer.close();
		}		
	}
}
