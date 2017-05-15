package hex.annotation;
import hex.di.IInjectorContainer;

/**
 * ...
 * @author 
 */
class MockMetadataClass implements IAnnotationReplace 
{

	public function new() 
	{
	}
	
	@Inject(MockConstants.NAME_ONE)
	public var injected_one:String;
	
	@Inject([MockConstants.NAME_TWO])
	public var injected_two:String;
	
	@Inject(MockConstants.NAME_THREE)
	@Optional(MockConstants.BOOL_TRUE)
	public var injected_optional:String;
	
	@PostConstruct( MockConstants.NUMBER_ONE )
	public function method():Void
	{
		
	}
	
	@Inject(MockConstants.NAME_ONE, MockConstants.NAME_TWO)
	public function methodWithMultipleArgs(arg0:String, arg1:String):Void
	{
		
	}
	
	@Inject(null, MockConstants.NAME_THREE)
	public function methodWithMultipleArgsMixed(arg0:String, arg1:String):Void
	{
		
	}
	
}

class MockMetadataClassWithLocalVars implements IAnnotationReplace
{
	static var NAME_ONE = "local one";
	public static var NAME_TWO = "local two";
	public static var NAME_THREE = "local three";
	static var BOOL_TRUE = true;
	static var NUMBER_ONE = 1;
	
	
	@Inject(NAME_ONE)
	public var injected_one:String;
	
	@Inject([NAME_TWO])
	public var injected_two:String;
	
	@Inject(NAME_THREE)
	@Optional(BOOL_TRUE)
	public var injected_optional:String;
	
	@PostConstruct( NUMBER_ONE )
	public function method():Void
	{
		
	}
	
	@Inject(NAME_ONE, NAME_TWO)
	public function methodWithMultipleArgs(arg0:String, arg1:String):Void
	{
		
	}
	
	@Inject(null, NAME_THREE)
	public function methodWithMultipleArgsMixed(arg0:String, arg1:String):Void
	{
		
	}
}

class MockInjectorContainerExtendsMockMetadata extends MockMetadataClass implements IInjectorContainer
{
	
}

class MockInjectorContainerExtendsMockMetadataWithLocalVars extends MockMetadataClassWithLocalVars implements IInjectorContainer
{
	
}

class MockMetadataClassWithInjectorContainer implements IInjectorContainer implements IAnnotationReplace 
{
	public function new() 
	{
	}
	
	@Inject(MockConstants.NAME_THREE)
	@Optional(MockConstants.BOOL_TRUE)
	public var injected_optional:String;
	
}
/*
// Doesn't compile
class MockMetadataClassWithInjectorContainerDifferentOrder implements IAnnotationReplace implements IInjectorContainer 
{
	public function new() 
	{
	}
	
	@Inject(MockConstants.NAME_THREE)
	@Optional(MockConstants.BOOL_TRUE)
	public var injected_optional:String;
	
}
*/