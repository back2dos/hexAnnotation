package hex;

import hex.annotation.AnnotationReaderTest;

/**
 * ...
 * @author Francis Bourre
 */
class HexAnnotationSuite
{
	@Suite( "Annotation suite" )
    public var list : Array<Class<Dynamic>> = [ AnnotationReaderTest ];
}