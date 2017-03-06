package hex.di.reflect;

import hex.error.NullPointerException;

/**
 * ...
 * @author Francis Bourre
 */
class FastClassDescriptionProvider implements IClassDescriptionProvider
{
    public function new(){}

    inline public function getClassDescription( type : Class<Dynamic> ) : ClassDescription
    {
		return Reflect.getProperty( type, "__INJECTION_DATA" );
    }
}