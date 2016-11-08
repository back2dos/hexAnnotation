package hex;

import hex.annotation.AnnotationReaderTest;
import hex.log.AnnotationLogSuite;

/**
 * ...
 * @author Francis Bourre
 */
class HexAnnotationSuite
{
	@Suite( "Annotation suite" )
    public var list : Array<Class<Dynamic>> = [ AnnotationLogSuite, AnnotationReaderTest ];
}