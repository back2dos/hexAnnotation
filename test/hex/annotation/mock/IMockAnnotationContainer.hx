package hex.annotation.mock;

/**
 * @author Francis Bourre
 */
#if !macro
@:remove
@:autoBuild( hex.annotation.AnnotationReader.readMetadata( hex.annotation.mock.IMockAnnotationContainer, [ "Inject", "Language", "Test", "PostConstruct", "Optional", "ConstructID" ] ) )
#end
interface IMockAnnotationContainer
{
	
}