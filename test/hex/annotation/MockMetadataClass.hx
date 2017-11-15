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

class MockMetadataClassWithFQCN implements IAnnotationReplace 
{

	public function new() 
	{
	}
	
	@Inject(hex.annotation.MockConstants.NAME_ONE)
	public var injected_one:String;
	
	@Inject([hex.annotation.MockConstants.NAME_TWO])
	public var injected_two:String;
	
	@Inject(hex.annotation.MockConstants.NAME_THREE)
	@Optional(hex.annotation.MockConstants.BOOL_TRUE)
	public var injected_optional:String;
	
	@PostConstruct( hex.annotation.MockConstants.NUMBER_ONE )
	public function method():Void
	{
		
	}
	
	@Inject(hex.annotation.MockConstants.NAME_ONE, hex.annotation.MockConstants.NAME_TWO)
	public function methodWithMultipleArgs(arg0:String, arg1:String):Void
	{
		
	}
	
	@Inject(null, hex.annotation.MockConstants.NAME_THREE)
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

class MockMetadataClassWithInjectorContainer implements IInjectorContainer implements IAnnotationReplace 
{
	public function new() 
	{
	}
	
	@Inject(MockConstants.NAME_THREE)
	@Optional(MockConstants.BOOL_TRUE)
	public var injected_optional:String;
	
}

class MockMetadataClassWithInjectorContainerWithFQCN implements IInjectorContainer implements IAnnotationReplace 
{
	public function new() 
	{
	}
	
	@Inject(hex.annotation.MockConstants.NAME_THREE)
	@Optional(hex.annotation.MockConstants.BOOL_TRUE)
	public var injected_optional:String;
	
}

class MockMetadataClassWithInjectorContainerWithLocalVars implements IInjectorContainer implements IAnnotationReplace 
{
	public static var NAME_THREE = "local three";
	public static var BOOL_TRUE = true;
	
	public function new() 
	{
	}
	
	@Inject(NAME_THREE)
	@Optional(BOOL_TRUE)
	public var injected_optional:String;
	
}

class MockMetadataClassWithInjectorContainerDifferentOrder implements IAnnotationReplace implements IInjectorContainer 
{
	public function new() 
	{
	}
	
	@Inject(MockConstants.NAME_THREE)
	@Optional(MockConstants.BOOL_TRUE)
	public var injected_optional:String;
	
}
