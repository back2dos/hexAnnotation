package hex.annotation;
import haxe.rtti.Meta;
import hex.annotation.MockMetadataClass.MockMetadataClassWithInjectorContainerWithLocalVars;
import hex.annotation.MockMetadataClass.MockMetadataClassWithLocalVars;
import hex.di.reflect.ClassDescription;
import hex.di.reflect.FastClassDescriptionProvider;
import hex.di.reflect.PropertyInjection;
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
	
	@Test("Metadata transformed - local vars")
	public function testMetadataTransformedLocalVars()
	{
		var expectedMeta = {
			injected_one : {
				Inject : [injected_one_local.n]
			}, 
			injected_two : {
				Inject : [injected_two_local.n]
			}, 
			injected_optional : {
				Inject : [injected_optional_local.n], 
				Optional : [injected_optional_local.o]
			}, 
			method : {
				PostConstruct : [method_local.o]
			}, 
			methodWithMultipleArgs : {
				Inject : [methodWithMultipleArgs_local.a[0].n, methodWithMultipleArgs_local.a[1].n]
			}, 
			methodWithMultipleArgsMixed : {
				Inject : [null, methodWithMultipleArgsMixed_local.a[1].n]
			}
		};
		
		var meta = Meta.getFields(MockMetadataClassWithLocalVars);
		
		Assert.isNotNull(meta);
		Assert.deepEquals(expectedMeta, meta);
	}
	
	@Test("Class description transformed")
	public function testClassDescriptionTransformed()
	{
		var provider = new FastClassDescriptionProvider();
		var description = provider.getClassDescription( MockMetadataClassWithInjectorContainer );
		
		Assert.isNotNull( description, "description should not be null" );
		
		Assert.arrayDeepContainsElementsFrom(description.p, [injected_optional]);
	}
	
	@Test("Class description transformed with local vars")
	public function testClassDescriptionTransformedWithLocalVars()
	{
		var provider = new FastClassDescriptionProvider();
		var description = provider.getClassDescription( MockMetadataClassWithInjectorContainerWithLocalVars );
		
		Assert.isNotNull( description, "description should not be null" );
		
		Assert.arrayDeepContainsElementsFrom(description.p, [injected_optional_local]);
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
	
	//------------ local vars expected values
	
	static var injected_one_local = {
		p:"injected_one",
		t:"String",
		n:"local one",
		o:false
	};
	
	static var injected_two_local = {
		p:"injected_two",
		t:"String",
		n:"local two",
		o:false
	};
	
	static var injected_optional_local = {
		p:"injected_optional",
		t:"String",
		n:"local three",
		o:true
	};
	
	
	static var methodWithMultipleArgs_local = {
		m: "methodWithMultipleArgs",
		a: [{
			t:"String", 
			n:"local one", 
			o:false
		},{
			t:"String", 
			n:"local two", 
			o:false
		}]
	};
	static var methodWithMultipleArgsMixed_local = {
		m: "methodWithMultipleArgsMixed",
		a:[{
			t:"String", 
			n:"", 
			o:false
		},{
			t:"String", 
			n:"local three", 
			o:false
		}]
	};
	
	static var method_local = {
		m:"method", 
		a:[], 
		o:1
	};
	
}