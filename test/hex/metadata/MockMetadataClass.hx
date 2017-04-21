package hex.metadata;
import hex.di.IInjectorContainer;

/**
 * ...
 * @author 
 */
class MockMetadataClass implements IMetadataReplace 
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

class MockInjectorContainerExtendsMockMetadata extends MockMetadataClass implements IInjectorContainer
{
	
}

class MockMetadataClassWithInjectorContainer implements IInjectorContainer implements IMetadataReplace 
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
class MockMetadataClassWithInjectorContainerDifferentOrder implements IMetadataReplace implements IInjectorContainer 
{
	public function new() 
	{
	}
	
	@Inject(MockConstants.NAME_THREE)
	@Optional(MockConstants.BOOL_TRUE)
	public var injected_optional:String;
	
}
*/