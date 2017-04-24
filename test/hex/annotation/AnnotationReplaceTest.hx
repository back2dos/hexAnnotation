package hex.annotation;
import haxe.rtti.Meta;
import hex.di.reflect.ClassDescription;
import hex.di.reflect.FastClassDescriptionProvider;
import hex.di.reflect.PropertyInjection;
import hex.annotation.MockMetadataClass.MockInjectorContainerExtendsMockMetadata;
import hex.annotation.MockMetadataClass.MockMetadataClassWithInjectorContainer;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author 
 */
class AnnotationReplaceTest 
{
	public function new() {}
	
	@Test("Metadata transformed")
	public function testMetadataTransformed()
	{
		var expectedMeta = {
			injected_one : {
				Inject : [injected_one.n]
			}, 
			injected_two : {
				Inject : [injected_two.n]
			}, 
			injected_optional : {
				Inject : [injected_optional.n], 
				Optional : [injected_optional.o]
			}, 
			method : {
				PostConstruct : [method.o]
			}, 
			methodWithMultipleArgs : {
				Inject : [methodWithMultipleArgs.a[0].n, methodWithMultipleArgs.a[1].n]
			}, 
			methodWithMultipleArgsMixed : {
				Inject : [null, methodWithMultipleArgsMixed.a[1].n]
			}
		};
		
		var meta = Meta.getFields(MockMetadataClass);
		
		Assert.isNotNull(meta);
		Assert.deepEquals(expectedMeta, meta);
	}
	
	@Test("Class description transformed")
	public function testClassDescriptionTransformed()
	{
		var provider = new FastClassDescriptionProvider();
		var description = provider.getClassDescription( MockMetadataClassWithInjectorContainer );
		
		Assert.isNotNull( description, "description should not be null" );
		
		Assert.arrayDeepContainsElementsFrom([injected_optional], description.p);
	}
	
	@Test("Class description transformed extends")
	public function testClassDescriptionTransformedExtends()
	{
		var provider = new FastClassDescriptionProvider();
		var description = provider.getClassDescription( MockInjectorContainerExtendsMockMetadata );
		
		Assert.isNotNull( description, "description should not be null" );
		
		// Check properties
		Assert.arrayDeepContainsElementsFrom([injected_one, injected_two, injected_optional], description.p);
		
		// Check methods
		Assert.arrayDeepContainsElementsFrom([methodWithMultipleArgs, methodWithMultipleArgsMixed], description.m);
		
		//Check postConstruct
		Assert.arrayDeepContainsElementsFrom([method], description.pc);
	}
	
	// Expected reflected data:
	
	static var injected_one = {
		p:"injected_one",
		t:"String",
		n:"one",
		o:false
	};
	
	static var injected_two = {
		p:"injected_two",
		t:"String",
		n:"two",
		o:false
	};
	
	static var injected_optional = {
		p:"injected_optional",
		t:"String",
		n:"three",
		o:true
	};
	
	static var methodWithMultipleArgs = {
		m: "methodWithMultipleArgs",
		a: [{
			t:"String", 
			n:"one", 
			o:false
		},{
			t:"String", 
			n:"two", 
			o:false
		}]
	};
	static var methodWithMultipleArgsMixed = {
		m: "methodWithMultipleArgsMixed",
		a:[{
			t:"String", 
			n:"", 
			o:false
		},{
			t:"String", 
			n:"three", 
			o:false
		}]
	};
	
	static var method = {
		m:"method", 
		a:[], 
		o:1
	};
	
}