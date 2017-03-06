package hex.di.reflect;

import hex.di.reflect.FastClassDescriptionProvider;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class FastClassDescriptionProviderTest
{
	@Test( "Test getClassDescription" )
	public function testGetClassDescription() : Void
	{
		var provider 	= new FastClassDescriptionProvider();
		var description = provider.getClassDescription( MockClassInjectee );
		Assert.isNotNull( description, "description should not be null" );
		Assert.deepEquals( MockClass.__INJECTION_DATA, description, "description should be the same" );
	}
}

private class MockClass
{
	static public var __INJECTION_DATA : ClassDescription = { c: { a: [] }, p: [], m: [], pc: [], pd: [] };
}