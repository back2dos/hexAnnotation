# hexAnnotation

[![TravisCI Build Status](https://travis-ci.org/DoclerLabs/hexAnnotation.svg?branch=master)](https://travis-ci.org/DoclerLabs/hexAnnotation)
Utilities for reading and writing class metadata

## Dependencies

* [hexCore](https://github.com/DoclerLabs/hexCore)


## Features

- Read metadata at compile time.
- Handles inheritance chain.
- Read properties and methods signatures (can be used by DI frameworks).
- Filter metadata parsing with a list of metadata names.
- Compress fields metadata to new class metadata.

## Simple example
```haxe
@:autoBuild( annotation.AnnotationReader.readMetadata( "annotation.mock.IMockAnnotationContainer", [ "Inject", "Language", "Test", "PostConstruct", "Optional", "ConstructID" ] ) )
interface IMockAnnotationContainer
{
	
}
```