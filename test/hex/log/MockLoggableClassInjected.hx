package hex.log;

import hex.di.IInjectorContainer;
import hex.log.IsLoggable;

/**
 * ...
 * @author Francis Bourre
 */
class MockLoggableClassInjected implements IsLoggable implements IInjectorContainer
{
	public function new() 
	{
		
	}
	
	@Debug
	public function debug( s : String, i : Int ) : Void
	{
		
	}
}