package hex.di;
import hex.di.reflect.AnnotationReflectSuite;

/**
 * ...
 * @author Francis Bourre
 */
class AnnotationDiSuite
{
    @Suite( "Di" )
    public var list : Array<Class<Dynamic>> = [ AnnotationReflectSuite ];
}