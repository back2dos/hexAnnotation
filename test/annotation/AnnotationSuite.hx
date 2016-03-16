package annotation;

/**
 * ...
 * @author Francis Bourre
 */
class AnnotationSuite
{
	@Suite( "Annotation suite" )
    public var list : Array<Class<Dynamic>> = [ AnnotationReaderTest ];
}