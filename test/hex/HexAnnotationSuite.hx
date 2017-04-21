package hex;

import hex.di.AnnotationDiSuite;
import hex.log.AnnotationLogSuite;
import hex.annotation.AnnotationTransformSuite;

/**
 * ...
 * @author Francis Bourre
 */
class HexAnnotationSuite
{
	@Suite( "Annotation suite" )
    public var list : Array<Class<Dynamic>> = [
		AnnotationLogSuite,
		AnnotationDiSuite,
		AnnotationTransformSuite
	];
}