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
	
	public static function processParam(expression:Expr):Expr
	{
		switch(expression.expr)
		{
			case EField(_.expr => EConst(CIdent(i)), str):
				return processConst(getId(i, str), processForeignConst.bind(i, str, expression.pos), expression);
			case EField(e, str):
				function getPath(expr:Expr):String
				{
					return switch(expr.expr)
					{
						case EField(e, str): '${getPath(e)}.$str';
						case EConst(CIdent(i)): i;
						case _: null;
					}
				}
				var path = getPath(e);
				return processConst(getId(path, str), processForeignConst.bind(path, str, expression.pos), expression);
			case EConst(CIdent(i)) if (i != "null"):
				return processConst(getLocalId(i), processLocalConst.bind(i, expression.pos), expression);
			case EConst(c):
				return expression;
			case _:
				logger.debug(expression);
				logger.debug(expression.expr);
				Context.error('Unsupported metadata statement: ${expression.expr}', expression.pos);
				return null;
		}
	}
	
	static inline function getLocalId(field:String):String
	{
		return getId(Context.getLocalClass().get().name, field);
	}
	
	static inline function getId(clss:String, field:String)
	{
		return '$clss.$field';
	}
	
	static function processConst(id:String, findFunc:Void->Expr, originalExpression:Expr):Expr
	{
		if (staticsCache == null)
		{
			staticsCache = new Map<String, Expr>();
		}
		if (!staticsCache.exists(id))
		{
			var e = findFunc();
			if(e != null)
			{
				staticsCache.set(id, e);
			}
			else
			{
				staticsCache.set(id, originalExpression);
				logger.warn('Constant "$id" not found');//, originalExpression.pos
			}
		}
		return staticsCache.get(id);
	}
	
	static function processLocalConst(field:String, pos:Position):Expr
	{
		var matchingFields = Context.getBuildFields().filter(function (f) return f.access.indexOf(AStatic) != -1 && f.name == field );
		if(matchingFields.length == 1)
		{
			return switch(matchingFields[0].kind)
			{
				case FieldType.FVar(ct, e): macro $v{e.getValue()};
				case _: null;
			}
		}
		return null;
	}
	
	static function processForeignConst(clss:String, field:String, pos:Position):Expr
	{
		var clss = try Context.getType(clss).getClass() catch (_:Dynamic) null;
		if (clss == null) return null;
		
		var statics = clss.statics.get();
		for (stat in statics)
		{
			if (stat.isPublic && stat.name == field)
			{
				return switch(stat.expr().expr)
				{
					case TConst(TString(v)):
						macro $v{v};
					case TConst(TInt(v)):
						macro $v{v};
					case TConst(TBool(v)):
						macro $v{v};
					case _:
						logger.debug(stat);
						Context.error('Unhandled constant type: ${stat}', pos);
						null;
				}
			}
		}
		return null;
	}
	
}
#end