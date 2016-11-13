package hex.di;

/**
 * ...
 * @author Francis Bourre
 */
class AnnotationDiSuite
{
    @Suite( "Di" )
    public var list : Array<Class<Dynamic>> = [ AnnotationReflectSuite ];
}