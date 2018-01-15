package hex.di;

import hex.di.annotation.FastAnnotationReaderTest;

/**
 * ...
 * @author Francis Bourre
 */
class AnnotationDiSuite
{
    @Suite( "Di" )
    public var list : Array<Class<Dynamic>> = [ FastAnnotationReaderTest ];
}