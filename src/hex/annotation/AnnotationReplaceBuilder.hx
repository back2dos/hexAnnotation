package hex.annotation;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.MetadataEntry;
import hex.log.ILogger;
import hex.log.LogManager;

using haxe.macro.Tools;
using Lambda;

#if macro
class AnnotationReplaceBuilder 
{
	
	static var staticsCache:Map<String,Expr>;
	
	static var logger:ILogger;

	public static macro function build():Array<Field>
	{
		if (logger == null)
		{
			logger = LogManager.getLoggerByClass(AnnotationReplaceBuilder);
		}
		
		var fields = Context.getBuildFields();
		fields.map(function (f)
		{
			f.meta.map(processMetadata);
		});
		
		return fields;
	}
	
	static function processMetadata(m:MetadataEntry):Void
	{
		m.params = m.params.flatMap(function(p){
			switch(p.expr)
			{
				case EArrayDecl(arr):
					return arr.map(processParam);
				case _:
					return [processParam(p)];
			}
		}).array();
	}
	
	static function processParam(e:Expr):Expr
	{
		switch(e.expr)
		{
			case EField(_.expr => EConst(CIdent(i)), str):
				return processConst(i, str, e.pos);
			case EConst(c):
				return e;
			case _:
				logger.debug(e);
				logger.debug(e.expr);
				Context.error('Unsupported metadata statement: ${e.expr}', e.pos);
				return null;
		}
	}
	
	static function processConst(clss:String, field:String, pos:Position):Expr
	{
		if (staticsCache == null)
		{
			staticsCache = new Map<String, Expr>();
		}
		var id = '$clss.$field';
		if (!staticsCache.exists(id))
		{
			var statics = Context.getType(clss).getClass().statics.get();
			var found = false;
			for (stat in statics)
			{
				if (stat.isPublic && stat.name == field)
				{
					found = true;
					switch(stat.expr().expr)
					{
						case TConst(TString(v)):
							staticsCache.set(id, macro $v{v});
						case TConst(TInt(v)):
							staticsCache.set(id, macro $v{v});
						case TConst(TBool(v)):
							staticsCache.set(id, macro $v{v});
							
						case _:
							logger.debug(stat);
							Context.error('Unhandled constant type: ${stat}', pos);
					}
					break;
				}
			}
			if (!found)
			{
				Context.error('Constant "$id" not found', pos);
			}
		}
		return staticsCache.get(id);
	}
	
}
#end