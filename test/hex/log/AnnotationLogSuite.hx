package hex.log;

/**
 * ...
 * @author Francis Bourre
 */
class AnnotationLogSuite
{
    @Suite( "Log" )
    public var list : Array<Class<Dynamic>> = [ IsLoggableTest ];
}