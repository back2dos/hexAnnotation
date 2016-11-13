package hex;

import hex.log.AnnotationLogSuite;

/**
 * ...
 * @author Francis Bourre
 */
class HexAnnotationSuite
{
	@Suite( "Annotation suite" )
    public var list : Array<Class<Dynamic>> = [ AnnotationLogSuite ];
}