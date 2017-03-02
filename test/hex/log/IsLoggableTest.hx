package hex.log;

import hex.domain.Domain;
import haxe.PosInfos;
import hex.log.ILogger;
import hex.log.ILoggerContext;
import hex.log.LogLevel;
import hex.log.message.IMessage;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class IsLoggableTest 
{
	public var loggable 	: MockLoggableClass;
	public var extLoggable 	: ExtendedMockLoggableClass;
	public var logger		: MockLogger;
	
	@Before
	public function setUp(): Void
	{
		loggable 		= new MockLoggableClass();
		logger 			= new MockLogger();
		loggable.logger = logger;
	}
	
	#if debug
	@Test( "test debug" )
	public function testDebug(): Void
	{
		loggable.debug( "debug", 1 );
		var args : Array<Dynamic> = [ "hex.log.MockLoggableClass::debug", "debug", 1 ];
		
		Assert.arrayContainsElementsFrom( args, logger.debugArg );
		Assert.isNull( logger.infoArg );
		Assert.isNull( logger.warnArg );
		Assert.isNull( logger.errorArg );
		Assert.isNull( logger.fatalArg );
	}
	
	@Test( "test info" )
	public function testInfo(): Void
	{
		loggable.info( "info", 2 );
		var args : Array<Dynamic> = [ "hex.log.MockLoggableClass::info", "info", 2 ];
		
		Assert.deepEquals( args, logger.infoArg );
		Assert.isNull( logger.debugArg );
		Assert.isNull( logger.warnArg );
		Assert.isNull( logger.errorArg );
		Assert.isNull( logger.fatalArg );
	}
	
	@Test( "test warn" )
	public function testWarn(): Void
	{
		loggable.warn( "warn", 3 );
		var args : Array<Dynamic> = [ "hex.log.MockLoggableClass::warn", "warn", 3 ];
		
		Assert.deepEquals( args, logger.warnArg );
		Assert.isNull( logger.debugArg );
		Assert.isNull( logger.infoArg );
		Assert.isNull( logger.errorArg );
		Assert.isNull( logger.fatalArg );
	}
	
	@Test( "test error" )
	public function testError(): Void
	{
		loggable.error( "error", 4 );
		var args : Array<Dynamic> = [ "hex.log.MockLoggableClass::error", "error", 4 ];
		
		Assert.deepEquals( args, logger.errorArg );
		Assert.isNull( logger.debugArg );
		Assert.isNull( logger.infoArg );
		Assert.isNull( logger.warnArg );
		Assert.isNull( logger.fatalArg );
	}
	
	@Test( "test fatal" )
	public function testFatal(): Void
	{
		loggable.fatal( "fatal", 5 );
		var args : Array<Dynamic> = [ "hex.log.MockLoggableClass::fatal", "fatal", 5 ];
		
		Assert.deepEquals( args, logger.fatalArg );
		Assert.isNull( logger.debugArg );
		Assert.isNull( logger.infoArg );
		Assert.isNull( logger.warnArg );
		Assert.isNull( logger.errorArg );
	}
	
	@Test( "test custom message" )
	public function testCustomMessage(): Void
	{
		loggable.debugCustomMessage( "debug", 6 );
		var args : Array<Dynamic> = [ "customMessage", "debug", 6 ];
		
		Assert.deepEquals( args, logger.debugArg );
		Assert.isNull( logger.infoArg );
		Assert.isNull( logger.warnArg );
		Assert.isNull( logger.errorArg );
		Assert.isNull( logger.fatalArg );
	}
	
	@Test( "test custom arguments with custom message" )
	public function testCustomArgumentsWithCustomMessage(): Void
	{
		loggable.debugCustomArgument( "debug", 7 );
		var args : Array<Dynamic> = [ "anotherMessage", 7, "member" ];
		
		Assert.deepEquals( args, logger.debugArg );
		Assert.isNull( logger.infoArg );
		Assert.isNull( logger.warnArg );
		Assert.isNull( logger.errorArg );
		Assert.isNull( logger.fatalArg );
	}
	
	@Test( "test interfaces implementation order" )
	public function testInterfacesImplementationOrder() : Void
	{
		var loggable = new MockLoggableClassInjected();
		var p = MockLoggableClassInjected.__INJECTION_DATA.p.filter( function ( o ) { return (cast o).p == "logger" && (cast o).t == "hex.log.ILogger"; } );
		Assert.equals( 1, p.length, "'MockLoggableClassInjected' should have reflection data for its logger property" );
	}
	#end
}

private class MockLogger implements ILogger
{
	public var debugArg : Dynamic;
	public var infoArg 	: Dynamic;
	public var warnArg 	: Dynamic;
	public var errorArg : Dynamic;
	public var fatalArg : Dynamic;
	
	public function new()
	{
		
	}
	
	public function debug(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		debugArg = message;
	}
	
	public function info(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		infoArg = message;
	}
	
	public function warn(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		warnArg = message;
	}
	
	public function error(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		errorArg = message;
	}
	
	public function fatal(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		fatalArg = message;
	}
	
	public function debugMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		
	}
	
	public function infoMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		
	}
	
	public function warnMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		
	}
	
	public function errorMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		
	}
	
	public function fatalMessage(message:IMessage, ?posInfos:PosInfos):Void 
	{
		
	}
	
	public function log(level:LogLevel, message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		
	}
	
	public function logMessage(level:LogLevel, message:IMessage, ?posInfos:PosInfos):Void 
	{
		
	}
	
	public function getLevel():LogLevel 
	{
		return LogLevel.OFF;
	}
	
	public function getName():String 
	{
		return null;
	}
	
	public function getContext():ILoggerContext 
	{
		return null;
	}
	
	
}
