package hex.log;

import hex.log.ExtendedMockLoggableClass.AnotherExtendedMockLoggableClass;
import hex.log.ExtendedMockLoggableClass.ClassThatExtendsClassWithVariableWithoutType;
import hex.log.ExtendedMockLoggableClass.ClassWithVariableWithoutType;
import hex.log.ExtendedMockLoggableClass.ExtendsLoggableAndOverridesLogger;
import hex.log.ExtendedMockLoggableClass.ExtendsLoggableWithCustomLogger;
import hex.log.ExtendedMockLoggableClass.MockLoggableClassWithCustomLogger;
import hex.log.ExtendedMockLoggableClass.MockLoggableWithExtendsCustomLogger;
import hex.unittest.assertion.Assert;

class IsLoggableExtendsAndCustomCasesTest 
{

	public function new() 
	{
	}
	
	var logger:MockLogger;
	
	@Before
	public function setup()
	{
		logger = new MockLogger();
	}
	
	@Test("Test extends")
	public function testExtends()
	{
		var extended = new ExtendedMockLoggableClass();
		
		extended.logger = logger;
		extended.debugNoArgs();
		
		var message = "{}()";
		var args : Array<Dynamic> = ["debugNoArgs"];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
	}
	
	@Test("Test double extends")
	public function testDoubleExtends()
	{
		var extended = new AnotherExtendedMockLoggableClass();
		
		extended.logger = logger;
		extended.debugNoArgs();
		
		var message = "{}()";
		var args : Array<Dynamic> = ["debugNoArgs"];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
	}
	
	@Test("Test custom logger")
	public function testCustomLogger()
	{
		var custom = new MockLoggableClassWithCustomLogger();
		
		custom.myLogger = logger;
		custom.callDebug();
		
		var message = "{}()";
		var args : Array<Dynamic> = ["callDebug"];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
	}
	
	@Test("Test extends loggable with custom logger")
	public function testExtendsLoggableWithCustomLogger()
	{
		var custom = new ExtendsLoggableWithCustomLogger();
		
		custom.myLogger = logger;
		custom.callDebugExtend();
		
		var message = "{}()";
		var args : Array<Dynamic> = ["callDebugExtend"];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
	}
	
	@Test("Test extends class with custom logger")
	public function testExtendsClassWithCustomLogger()
	{
		var custom = new MockLoggableWithExtendsCustomLogger();
		
		custom.custom = logger;
		custom.callDebugExtend();
		
		var message = "{}()";
		var args : Array<Dynamic> = ["callDebugExtend"];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
	}
	
	@Test("Test extends loggable with custom logger and defines own logger")
	public function testExtendsLoggableWithCustomLoggerAndDefinesOwn()
	{
		var custom = new ExtendsLoggableAndOverridesLogger();
		
		custom.overriddenLogger = logger;
		custom.callDebugExtend();
		
		var message = "{}()";
		var args : Array<Dynamic> = ["callDebugExtend"];
		
		Assert.deepEquals( args, logger.debugParams );
		Assert.equals(message, logger.debugMsg);
	}
	
	@Test("Test class with variable without type")
	public function testClassWithVariableWithoutType()
	{
		var type = new ClassWithVariableWithoutType();
		
		// This only needs to compile, functionality is tested in other tests
		Assert.isNull(type.logger);
	}
	
	@Test("Test class that extends class with variable without type")
	public function testClassThatExtendsClassWithVariableWithoutType()
	{
		var type = new ClassThatExtendsClassWithVariableWithoutType();
		
		// This only needs to compile, functionality is tested in other tests
		Assert.isNull(type.logger);
	}
	
}