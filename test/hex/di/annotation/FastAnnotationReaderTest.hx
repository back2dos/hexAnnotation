package hex.di.annotation;
import hex.unittest.assertion.Assert;

using hex.util.ArrayUtil;

/**
 * ...
 * @author ...
 */
class FastAnnotationReaderTest 
{

	@Test("Test FastAnnotationReader generates __INJECTION_DATA")
	public function testFastAnnotationReaderGeneratesInjectionData():Void
	{
		Assert.isNotNull(ClassWithAnnotationsOnce.__INJECTION_DATA);
		Assert.isTrue(ClassWithAnnotationsOnce.__INJECTION_DATA.p.count(p => p.p == "injectHere") == 1);
	}
	
	@Test("Test FastAnnotationReader keeps __INJECTION_DATA when called multiple times")
	public function testFastAnnotationReaderKeepsInjectionData():Void
	{
		Assert.isNotNull(ClassWithAnnotationsTwice.__INJECTION_DATA);
		Assert.isTrue(ClassWithAnnotationsTwice.__INJECTION_DATA.p.count(p => p.p == "injectHere") == 1);
	}
	
	@Test("Test FastAnnotationReader updates __INJECTION_DATA when adding fields")
	public function testFastAnnotationReaderUpdatesInjectionData():Void
	{
		Assert.isNotNull(ClassWithAnnotationsAdded.__INJECTION_DATA);
		Assert.isTrue(ClassWithAnnotationsAdded.__INJECTION_DATA.p.count(p => p.p == "injectHere") == 1);
		Assert.isTrue(ClassWithAnnotationsAdded.__INJECTION_DATA.p.count(p => p.p == "addedField") == 1);
	}
	
}

@:build(hex.di.annotation.AnnotationBuilder.reflectOnce())
private class ClassWithAnnotationsOnce
{
	@Inject
	public var injectHere:String;
}

@:build(hex.di.annotation.AnnotationBuilder.reflectTwice())
private class ClassWithAnnotationsTwice
{
	@Inject
	public var injectHere:String;
}

@:build(hex.di.annotation.AnnotationBuilder.reflectOnce())
@:build(hex.di.annotation.AnnotationBuilder.addFieldAndReflect())
private class ClassWithAnnotationsAdded
{
	@Inject
	public var injectHere:String;
}

