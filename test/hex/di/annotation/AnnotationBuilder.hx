package hex.di.annotation;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr.Field;

/**
 * ...
 * @author ...
 */
class AnnotationBuilder 
{

	macro public static function reflectOnce():Array<Field>
	{
		var fields = Context.getBuildFields();
		return FastAnnotationReader.reflect( macro hex.di.IInjectorContainer, fields );
	}
	
	macro public static function reflectTwice():Array<Field>
	{
		var fields = Context.getBuildFields();
		fields = FastAnnotationReader.reflect( macro hex.di.IInjectorContainer, fields );
		return FastAnnotationReader.reflect( macro hex.di.IInjectorContainer, fields );
	}
	
	macro public static function addFieldAndReflect():Array<Field>
	{
		var fields = Context.getBuildFields();
		fields.push({
			name: "addedField",
			access: [APublic],
			kind: FVar(macro :Int),
			pos: Context.currentPos(),
			meta: [{
				name: "Inject",
				params:[],
				pos:Context.currentPos()
			}]
		});
		return FastAnnotationReader.reflect( macro hex.di.IInjectorContainer, fields );
	}
	
}

#end
