package annotation.mock;

import annotation.AnnotationReader;

/**
 * @author Francis Bourre
 */
@:autoBuild( annotation.AnnotationReader.readMetadata( "annotation.mock.IMockAnnotationContainer", [ "Inject", "Language", "Test", "PostConstruct", "Optional", "ConstructID" ] ) )
interface IMockAnnotationContainer
{
	
}