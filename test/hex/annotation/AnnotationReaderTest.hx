package hex.annotation;

import hex.annotation.mock.IMockAnnotationContainer;
import hex.annotation.mock.MockAnnotationContainer;
import hex.annotation.mock.MockContainerWithoutAnnotation;
import hex.annotation.mock.MockExtendedAnnotationContainer;
import hex.domain.Domain;
import hex.log.ILogger;
import hex.log.Logger;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class AnnotationReaderTest
{
    static var _annotationProvider : IClassAnnotationDataProvider;

    @BeforeClass
    public static function beforeClass() : Void
    {
        AnnotationReaderTest._annotationProvider = new ClassAnnotationDataProvider( IMockAnnotationContainer );
    }

    @AfterClass
    public static function afterClass() : Void
    {
        AnnotationReaderTest._annotationProvider = null;
    }

    @Test( "test get annotation data with class name" )
    public function testGetAnnotationDataWithClassName() : Void
    {
        Assert.isNotNull( AnnotationReaderTest._annotationProvider, "annotation data map shouldn't be null" );
        Assert.isNotNull( AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockAnnotationContainer ), "'MockAnnotationContainer' class should be referenced" );
        Assert.isNotNull( AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockExtendedAnnotationContainer ), "'MockExtendedAnnotationContainer' class should be referenced" );

        var data0 : ClassAnnotationData = AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockAnnotationContainer );
        Assert.equals( Type.getClassName( MockContainerWithoutAnnotation ), data0.superClassName, "superClass name should be the same" );

        var data1 : ClassAnnotationData = AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockExtendedAnnotationContainer );
        Assert.equals( Type.getClassName( MockAnnotationContainer ), data1.superClassName, "superClass name should be the same" );
    }

    @Test( "test get annotation data from constructor" )
    public function testGetAnnotationDataFromConstructor() : Void
    {
        var data : ClassAnnotationData = AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockAnnotationContainer );
        Assert.isNotNull( data.constructorAnnotationData, "constructor annotation data shouldn't be null" );
        Assert.equals( "new", data.constructorAnnotationData.methodName, "constructor 'methodName' should be 'new'" );

        Assert.equals( 2, data.constructorAnnotationData.argumentDatas.length, "argument length should be 2" );
        var arg0 : ArgumentData = data.constructorAnnotationData.argumentDatas[ 0 ];
        Assert.equals( "domain", arg0.argumentName, "argument name should be the same" );
        Assert.equals( Type.getClassName( Domain ), arg0.argumentType, "argument type should be the same" );

        var arg1 : ArgumentData = data.constructorAnnotationData.argumentDatas[ 1 ];
        Assert.equals( "logger", arg1.argumentName, "argument name should be the same" );
        Assert.equals( Type.getClassName( ILogger ), arg1.argumentType, "argument type should be the same" );

        Assert.equals( 1, data.constructorAnnotationData.annotationDatas.length, "annotation length should be 1" );
        var annotationData : AnnotationData = data.constructorAnnotationData.annotationDatas[ 0 ];
        Assert.equals( "Inject", annotationData.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["a", 2, true], annotationData.annotationKeys, "annotation keys should be the same" );
    }

    @Test( "test get annotation data from properties" )
    public function testGetAnnotationDataFromProperties() : Void
    {
        var data : ClassAnnotationData = AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockAnnotationContainer );
        Assert.equals( 2, data.properties.length, "properties length should be 2" );

        var property0 : PropertyAnnotationData = data.properties[ 0 ];
        Assert.equals( "property", property0.propertyName, "property name should be the same" );
        Assert.equals( Type.getClassName( Logger ), property0.propertyType, "property type should be the same" );

        Assert.equals( 2, property0.annotationDatas.length, "annotation length should be 2" );
        var annotationData0 : AnnotationData = property0.annotationDatas[ 0 ];
        Assert.equals( "Inject", annotationData0.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["ID", "name", 3], annotationData0.annotationKeys, "annotation keys should be the same" );
        var annotationData1 : AnnotationData = property0.annotationDatas[ 1 ];
        Assert.equals( "Language", annotationData1.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["fr"], annotationData1.annotationKeys, "annotation keys should be the same" );

        var property1 : PropertyAnnotationData = data.properties[ 1 ];
        Assert.equals( "_privateProperty", property1.propertyName, "property name should be the same" );
        Assert.equals( "Int", property1.propertyType, "property type should be the same" );


        Assert.equals( 2, property1.annotationDatas.length, "annotation length should be 2" );
        var annotationData2 : AnnotationData = property1.annotationDatas[ 0 ];
        Assert.equals( "Inject", annotationData2.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["b", 3, false], annotationData2.annotationKeys, "annotation keys should be the same" );
        var annotationData3 : AnnotationData = property1.annotationDatas[ 1 ];
        Assert.equals( "Language", annotationData3.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["en"], annotationData3.annotationKeys, "annotation keys should be the same" );
    }

    @Test( "test get annotation data from methods" )
    public function testGetAnnotationDataFromMethods() : Void
    {
        var data : ClassAnnotationData = AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockAnnotationContainer );
        Assert.equals( 2, data.methods.length, "methods length should be 3" );

        var method0 : MethodAnnotationData = data.methods[ 0 ];
        Assert.equals( "testMethodWithPrim", method0.methodName, "method name should be the same" );
        Assert.equals( 5, method0.argumentDatas.length, "argument length should be 5" );
        Assert.equals( method0.argumentDatas[ 0 ].argumentName, "i", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 0 ].argumentType, "Int", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 1 ].argumentName, "u", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 1 ].argumentType, "UInt", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 2 ].argumentName, "b", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 2 ].argumentType, "Bool", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 3 ].argumentName, "s", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 3 ].argumentType, "String", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 4 ].argumentName, "f", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 4 ].argumentType, "Float", "argument data should be the same" );

        Assert.equals( 2, method0.annotationDatas.length, "annotation length should be 2" );
        var annotationData0 : AnnotationData = method0.annotationDatas[ 0 ];
        Assert.equals( "Test", annotationData0.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["testMethodWithPrimMetadata"], annotationData0.annotationKeys, "annotation keys should be the same" );
        var annotationData1 : AnnotationData = method0.annotationDatas[ 1 ];
        Assert.equals( "PostConstruct", annotationData1.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["0"], annotationData1.annotationKeys, "annotation keys should be the same" );

        var method1 : MethodAnnotationData = data.methods[ 1 ];
        Assert.equals( "_methodToOverride", method1.methodName, "method name should be the same" );
        Assert.equals( 1, method1.argumentDatas.length, "argument length should be 1" );
        Assert.equals( method1.argumentDatas[ 0 ].argumentName, "element", "argument data should be the same" );
        Assert.equals( method1.argumentDatas[ 0 ].argumentType, "hex.log.Logger", "argument data should be the same" );

        Assert.equals( 3, method1.annotationDatas.length, "annotation length should be 3" );
        var annotationData0 : AnnotationData = method1.annotationDatas[ 0 ];
        Assert.equals( "Test", annotationData0.annotationName, "annotation name should be the same" );
        Assert.equals( "methodToOverrideMetadata", annotationData0.annotationKeys[ 0 ], "annotation keys should be the same" );
        var annotationData1 : AnnotationData = method1.annotationDatas[ 1 ];
        Assert.equals( "PostConstruct", annotationData1.annotationName, "annotation name should be the same" );
        Assert.equals( 1, annotationData1.annotationKeys[ 0 ], "annotation keys should be the same" );
        var annotationData2 : AnnotationData = method1.annotationDatas[ 2 ];
        Assert.equals( "Optional", annotationData2.annotationName, "annotation name should be the same" );
        Assert.equals( true, annotationData2.annotationKeys[ 0 ], "annotation keys should be the same" );
    }

    @Test( "test get annotation data from extended constructor" )
    public function testGetAnnotationDataFromExtendedConstructor() : Void
    {
        var data : ClassAnnotationData = AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockExtendedAnnotationContainer );
        Assert.isNotNull( data.constructorAnnotationData, "constructor annotation data shouldn't be null" );
        Assert.equals( "new", data.constructorAnnotationData.methodName, "constructor 'methodName' should be 'new'" );

        Assert.equals( 3, data.constructorAnnotationData.argumentDatas.length, "argument length should be 3" );

        var arg0 : ArgumentData = data.constructorAnnotationData.argumentDatas[ 0 ];
        Assert.equals( "a", arg0.argumentName, "argument name should be the same" );
        Assert.equals( Type.getClassName( Array ), arg0.argumentType, "argument type should be the same" );

        var arg1 : ArgumentData = data.constructorAnnotationData.argumentDatas[ 1 ];
        Assert.equals( "extendedDomain", arg1.argumentName, "argument name should be the same" );
        Assert.equals( Type.getClassName( Domain ), arg1.argumentType, "argument type should be the same" );

        var arg2 : ArgumentData = data.constructorAnnotationData.argumentDatas[ 2 ];
        Assert.equals( "extendedLogger", arg2.argumentName, "argument name should be the same" );
        Assert.equals( Type.getClassName( ILogger ), arg2.argumentType, "argument type should be the same" );

        Assert.equals( 2, data.constructorAnnotationData.annotationDatas.length, "annotation length should be 2" );
        var annotationData0 : AnnotationData = data.constructorAnnotationData.annotationDatas[ 0 ];
        Assert.equals( "Inject", annotationData0.annotationName, "annotation name should be the same" );
        Assert.deepEquals( [ "d", 3, false ], annotationData0.annotationKeys, "annotation keys should be the same" );
        var annotationData1 : AnnotationData = data.constructorAnnotationData.annotationDatas[ 1 ];
        Assert.equals( "ConstructID", annotationData1.annotationName, "annotation name should be the same" );
        Assert.equals( 9, annotationData1.annotationKeys[ 0 ], "annotation keys should be the same" );
    }

    @Test( "test get annotation data from extended properties" )
    public function testGetAnnotationDataFromExtendedProperties() : Void
    {
        var data : ClassAnnotationData = AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockExtendedAnnotationContainer );
        Assert.equals( 3, data.properties.length, "properties length should be 3" );

        var property0 : PropertyAnnotationData = data.properties[ 0 ];
        Assert.equals( "property", property0.propertyName, "property name should be the same" );
        Assert.equals( Type.getClassName( Logger ), property0.propertyType, "property type should be the same" );

        Assert.equals( 2, property0.annotationDatas.length, "annotation length should be 2" );
        var annotationData0 : AnnotationData = property0.annotationDatas[ 0 ];
        Assert.equals( "Inject", annotationData0.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["ID", "name", 3], annotationData0.annotationKeys, "annotation keys should be the same" );
        var annotationData1 : AnnotationData = property0.annotationDatas[ 1 ];
        Assert.equals( "Language", annotationData1.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["fr"], annotationData1.annotationKeys, "annotation keys should be the same" );

        var property1 : PropertyAnnotationData = data.properties[ 1 ];
        Assert.equals( "_privateProperty", property1.propertyName, "property name should be the same" );
        Assert.equals( "Int", property1.propertyType, "property type should be the same" );

        Assert.equals( 2, property1.annotationDatas.length, "annotation length should be 2" );
        var annotationData2 : AnnotationData = property1.annotationDatas[ 0 ];
        Assert.equals( "Inject", annotationData2.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["b", 3, false], annotationData2.annotationKeys, "annotation keys should be the same" );
        var annotationData3 : AnnotationData = property1.annotationDatas[ 1 ];
        Assert.equals( "Language", annotationData3.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["en"], annotationData3.annotationKeys, "annotation keys should be the same" );

        var property2 : PropertyAnnotationData = data.properties[ 2 ];
        Assert.equals( "anotherProperty", property2.propertyName, "property name should be the same" );
        Assert.equals( "Bool", property2.propertyType, "property type should be the same" );

        Assert.equals( 2, property2.annotationDatas.length, "annotation length should be 2" );
        var annotationData3 : AnnotationData = property2.annotationDatas[ 0 ];
        Assert.equals( "Inject", annotationData2.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["anotherID", "anotherName", 3], annotationData3.annotationKeys, "annotation keys should be the same" );
        var annotationData4 : AnnotationData = property2.annotationDatas[ 1 ];
        Assert.equals( "Language", annotationData4.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["it"], annotationData4.annotationKeys, "annotation keys should be the same" );

    }

    @Test( "test get annotation data from extended methods" )
    public function testGetAnnotationDataFromExtendedMethods() : Void
    {
        var data : ClassAnnotationData = AnnotationReaderTest._annotationProvider.getClassAnnotationData( MockExtendedAnnotationContainer );
        Assert.equals( 3, data.methods.length, "methods length should be 3" );

        var method0 : MethodAnnotationData = data.methods[ 0 ];
        Assert.equals( "testMethodWithPrim", method0.methodName, "method name should be the same" );
        Assert.equals( 5, method0.argumentDatas.length, "argument length should be 5" );
        Assert.equals( method0.argumentDatas[ 0 ].argumentName, "i", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 0 ].argumentType, "Int", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 1 ].argumentName, "u", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 1 ].argumentType, "UInt", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 2 ].argumentName, "b", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 2 ].argumentType, "Bool", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 3 ].argumentName, "s", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 3 ].argumentType, "String", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 4 ].argumentName, "f", "argument data should be the same" );
        Assert.equals( method0.argumentDatas[ 4 ].argumentType, "Float", "argument data should be the same" );

        Assert.equals( 2, method0.annotationDatas.length, "annotation length should be 2" );
        var annotationData0 : AnnotationData = method0.annotationDatas[ 0 ];
        Assert.equals( "Test", annotationData0.annotationName, "annotation name should be the same" );
        Assert.deepEquals( ["testMethodWithPrimMetadata"], annotationData0.annotationKeys, "annotation keys should be the same" );
        var annotationData1 : AnnotationData = method0.annotationDatas[ 1 ];
        Assert.equals( "PostConstruct", annotationData1.annotationName, "annotation name should be the same" );
        Assert.equals( 0, annotationData1.annotationKeys[ 0 ], "annotation keys should be the same" );

        var method1 : MethodAnnotationData = data.methods[ 1 ];
        Assert.equals( "_methodToOverride", method1.methodName, "method name should be the same" );
        Assert.equals( 1, method1.argumentDatas.length, "argument length should be 1" );
        Assert.equals( method1.argumentDatas[ 0 ].argumentName, "element", "argument data should be the same" );
        Assert.equals( method1.argumentDatas[ 0 ].argumentType, "hex.log.Logger", "argument data should be the same" );

        Assert.equals( 3, method1.annotationDatas.length, "annotation length should be 3" );
        var annotationData0 : AnnotationData = method1.annotationDatas[ 0 ];
        Assert.equals( "Test", annotationData0.annotationName, "annotation name should be the same" );
        Assert.equals( "methodToOverrideMetadata", annotationData0.annotationKeys[ 0 ], "annotation keys should be the same" );
        var annotationData1 : AnnotationData = method1.annotationDatas[ 1 ];
        Assert.equals( "PostConstruct", annotationData1.annotationName, "annotation name should be the same" );
        Assert.equals( 3, annotationData1.annotationKeys[ 0 ], "annotation keys should be the same" );
        var annotationData2 : AnnotationData = method1.annotationDatas[ 2 ];
        Assert.equals( "Optional", annotationData2.annotationName, "annotation name should be the same" );
        Assert.equals( false, annotationData2.annotationKeys[ 0 ], "annotation keys should be the same" );

        var method2 : MethodAnnotationData = data.methods[ 2 ];
        Assert.equals( "anotherTestMethod", method2.methodName, "method name should be the same" );
        Assert.equals( 1, method2.argumentDatas.length, "argument length should be 1" );
        Assert.equals( method2.argumentDatas[ 0 ].argumentName, "f", "argument data should be the same" );
        Assert.equals( method2.argumentDatas[ 0 ].argumentType, "Float", "argument data should be the same" );

        Assert.equals( 2, method2.annotationDatas.length, "annotation length should be 2" );
        var annotationData0 : AnnotationData = method2.annotationDatas[ 0 ];
        Assert.equals( "Test", annotationData0.annotationName, "annotation name should be the same" );
        Assert.equals( "anotherTestMethodMetadata", annotationData0.annotationKeys[ 0 ], "annotation keys should be the same" );
        var annotationData1 : AnnotationData = method2.annotationDatas[ 1 ];
        Assert.equals( "PostConstruct", annotationData1.annotationName, "annotation name should be the same" );
        Assert.equals( 2, annotationData1.annotationKeys[ 0 ], "annotation keys should be the same" );
    }
}
