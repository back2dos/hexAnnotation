# hexAnnotation

[![TravisCI Build Status](https://travis-ci.org/DoclerLabs/hexAnnotation.svg?branch=master)](https://travis-ci.org/DoclerLabs/hexAnnotation)
Utilities for reading and writing class metadata

*Find more information about hexMachina on [hexmachina.org](http://hexmachina.org/)*

## Dependencies

* [hexCore](https://github.com/DoclerLabs/hexCore)
* [hexReflection](https://github.com/DoclerLabs/hexReflection)

## Features

- Read metadata at compile time.
- Handles inheritance chain.
- Read properties and methods signatures (to be used by DI frameworks).
- Export annotated (@Inject, @PostConstruct", @Optional, @PreDestroy) members information (essentially reflection data) to a static field instance.

## Simple example
```haxe
class MockClassInjectee implements IContainer
{
	@Inject( "id" )
	public function new( arg : Int ) 
	{
		//constructor informations will be stored
	}
	
	public function doSomething() : Void
	{
		//this method will be ignored
	}
	
	@PostConstruct( 1 )
	public function doSomething() : Void
	{
		//this method description will be stored as well
	}
}


@:autoBuild( hex.di.annotation.FastAnnotationReader.readMetadata( IContainer ) )
interface IContainer
{
	
}
```
