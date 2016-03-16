package hex.annotation;

/**
 * @author Francis Bourre
 */
interface IClassAnnotationDataProvider 
{
	function getClassAnnotationData( type : Class<Dynamic> ) : ClassAnnotationData;
}