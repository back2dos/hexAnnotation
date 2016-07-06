package hex.annotation;

import hex.collection.HashMap;

/**
 * ...
 * @author Francis Bourre
 */
class ClassAnnotationDataProvider implements IClassAnnotationDataProvider
{
	var _metadataName       : String;
    var _annotatedClasses   : HashMap<Class<Dynamic>, ClassAnnotationData>;
	
	public function new( type : Class<Dynamic> )
    {
        this._metadataName      = Type.getClassName( type );
        this._annotatedClasses  = new HashMap();
    }
	
	public function getClassAnnotationData( type : Class<Dynamic> ) : ClassAnnotationData
    {
        return this._annotatedClasses.containsKey( type ) ? this._annotatedClasses.get( type ) : this._getClassAnnotationData( type );
    }
	
	function _getClassAnnotationData( type : Class<Dynamic>)  : ClassAnnotationData
    {
		var field : ClassAnnotationData = Reflect.getProperty( type, "__INJECTION_DATA" );
		
		if ( field != null )
		{
			this._annotatedClasses.put( type, field );
			return field;
		}
		else
        {
            return null;
        }
    }
}