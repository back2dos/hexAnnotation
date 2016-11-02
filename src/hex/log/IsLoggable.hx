package hex.log;

import hex.di.IInjectorContainer;

/**
 * @author Francis Bourre
 */
#if !macro
@:remove
@:autoBuild( hex.log.LoggableBuilder.build() )
#end
interface IsLoggable
{
	
}