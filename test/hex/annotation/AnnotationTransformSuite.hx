package hex.annotation;

/**
 * ...
 * @author 
 */
class AnnotationTransformSuite 
{
	@Suite( "Metadata" )
    public var list : Array<Class<Dynamic>> = [
		AnnotationReplaceTest
	];
	
}