package hex;

import hex.di.AnnotationDiSuite;
import hex.log.AnnotationLogSuite;
import hex.metadata.AnnotationMetadataSuite;

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
		AnnotationMetadataSuite
	];
}