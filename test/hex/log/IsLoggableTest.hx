package hex.log;

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
		var args : Array<Dynamic> = [ "debug", "debug", 1 ];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals("{}(s='{}', i='{}')", logger.debugMsg);
		Assert.isNull( logger.infoParams );
		Assert.isNull( logger.warnParams );
		Assert.isNull( logger.errorParams );
		Assert.isNull( logger.fatalParams );
	}
	
	@Test( "test info" )
	public function testInfo(): Void
	{
		loggable.info( "info", 2 );
		var args : Array<Dynamic> = [ "info", "info", 2 ];
		
		Assert.deepEquals( args, logger.infoParams );
		Assert.equals("{}(s='{}', i='{}')", logger.infoMsg);
		Assert.isNull( logger.debugParams );
		Assert.isNull( logger.warnParams );
		Assert.isNull( logger.errorParams );
		Assert.isNull( logger.fatalParams );
	}
	
	@Test( "test warn" )
	public function testWarn(): Void
	{
		loggable.warn( "warn", 3 );
		var args : Array<Dynamic> = [ "warn", "warn", 3 ];
		
		Assert.deepEquals( args, logger.warnParams );
		Assert.equals("{}(s='{}', i='{}')", logger.warnMsg);
		Assert.isNull( logger.debugParams );
		Assert.isNull( logger.infoParams );
		Assert.isNull( logger.errorParams );
		Assert.isNull( logger.fatalParams );
	}
	
	@Test( "test error" )
	public function testError(): Void
	{
		loggable.error( "error", 4 );
		var args : Array<Dynamic> = [ "error", "error", 4 ];
		
		Assert.deepEquals( args, logger.errorParams );
		Assert.equals("{}(s='{}', i='{}')", logger.errorMsg);
		Assert.isNull( logger.debugParams );
		Assert.isNull( logger.infoParams );
		Assert.isNull( logger.warnParams );
		Assert.isNull( logger.fatalParams );
	}
	
	@Test( "test fatal" )
	public function testFatal(): Void
	{
		loggable.fatal( "fatal", 5 );
		var args : Array<Dynamic> = [ "fatal", "fatal", 5 ];
		
		Assert.deepEquals( args, logger.fatalParams );
		Assert.equals("{}(s='{}', i='{}')", logger.fatalMsg);
		Assert.isNull( logger.debugParams );
		Assert.isNull( logger.infoParams );
		Assert.isNull( logger.warnParams );
		Assert.isNull( logger.errorParams );
	}
	
	@Test( "test custom message" )
	public function testCustomMessage(): Void
	{
		loggable.debugCustomMessage( "debug", 6 );
		var message = "customMessage";
		var args : Array<Dynamic> = [ "debug", 6 ];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
		Assert.isNull( logger.infoParams );
		Assert.isNull( logger.warnParams );
		Assert.isNull( logger.errorParams );
		Assert.isNull( logger.fatalParams );
	}
	
	@Test( "test custom arguments with custom message" )
	public function testCustomArgumentsWithCustomMessage(): Void
	{
		loggable.debugCustomArgument( "debug", 7 );
		var message = "anotherMessage";
		var args : Array<Dynamic> = [ 7, "member" ];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
		Assert.isNull( logger.infoMsg );
		Assert.isNull( logger.warnMsg );
		Assert.isNull( logger.errorMsg );
		Assert.isNull( logger.fatalMsg );
	}
	
	@Test( "test custom message with included arguments" )
	public function testCustomMessageWithIncludedArguments(): Void
	{
		loggable.debugCustomMessageWithIncludedArgs( "debug", 8 );
		var message = "customMessage [s='{}', i='{}']";
		var args : Array<Dynamic> = [ "debug", 8 ];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
		Assert.isNull( logger.infoMsg );
		Assert.isNull( logger.warnMsg );
		Assert.isNull( logger.errorMsg );
		Assert.isNull( logger.fatalMsg );
	}
	
	@Test( "test custom message with custom arguments with included arguments" )
	public function testCustomMessageWithCustomArgumentsWithIncludedArguments(): Void
	{
		loggable.debugCustomArgumentWithIncludedArgs( "debug", 9 );
		var message = "anotherMessage [i='{}', this.member='{}']";
		var args : Array<Dynamic> = [ 9, "member" ];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
		Assert.isNull( logger.infoMsg );
		Assert.isNull( logger.warnMsg );
		Assert.isNull( logger.errorMsg );
		Assert.isNull( logger.fatalMsg );
	}
	
	@Test( "test custom arguments only" )
	public function testCustomArgumentsOnly(): Void
	{
		loggable.debugCustomArgumentOnly( "debug", 10 );
		var message = "{}(i='{}', this.member='{}')";
		var args : Array<Dynamic> = [ "debugCustomArgumentOnly", 10, "member" ];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
		Assert.isNull( logger.infoMsg );
		Assert.isNull( logger.warnMsg );
		Assert.isNull( logger.errorMsg );
		Assert.isNull( logger.fatalMsg );
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
	public var debugMsg : Dynamic;
	public var debugParams : Dynamic;
	public var infoMsg 	: Dynamic;
	public var infoParams 	: Dynamic;
	public var warnMsg 	: Dynamic;
	public var warnParams 	: Dynamic;
	public var errorMsg : Dynamic;
	public var errorParams : Dynamic;
	public var fatalMsg : Dynamic;
	public var fatalParams : Dynamic;
	
	public function new()
	{
		
	}
	
	public function debug(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		debugMsg = message;
		debugParams = params;
	}
	
	public function info(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		infoMsg = message;
		infoParams = params;
	}
	
	public function warn(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		warnMsg = message;
		warnParams = params;
	}
	
	public function error(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		errorMsg = message;
		errorParams = params;
	}
	
	public function fatal(message:Dynamic, ?params:Array<Dynamic>, ?posInfos:PosInfos):Void 
	{
		fatalMsg = message;
		fatalParams = params;
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
