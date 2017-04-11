package hex.log;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Printer;
import hex.di.annotation.FastAnnotationReader;
import hex.error.PrivateConstructorException;
import hex.util.MacroUtil;

/**
 * ...
 * @author Francis Bourre
 */
class LoggableBuilder
{
#if macro

	public static inline var DebugAnnotation 	= "Debug";
	public static inline var InfoAnnotation 	= "Info";
	public static inline var WarnAnnotation 	= "Warn";
	public static inline var ErrorAnnotation 	= "Error";
	public static inline var FatalAnnotation 	= "Fatal";
	
	/** @private */
    function new()
    {
        throw new PrivateConstructorException( "This class can't be instantiated." );
    }
	
	macro static public function build() : Array<Field> 
	{
		var fields = Context.getBuildFields();

		if ( Context.getLocalClass().get().isInterface )
		{
			return fields;
		}
		
		for ( f in fields )
		{
			if ( f.name == "logger" )
			{
				Context.error( "'logger' member will be added automatically in class that implements 'IsLoggable'", f.pos );
			}
		}
		
		var shouldAddField = true;
		var superClass = Context.getLocalClass().get().superClass;
		if ( superClass != null )
		{
			var classType = MacroUtil.getClassType( superClass.t.toString() );
			if ( MacroUtil.implementsInterface( classType, MacroUtil.getClassType( Type.getClassName( IsLoggable ) ) ) )
			{
				shouldAddField = false;
			}
		}
		
		if ( shouldAddField )
		{
			fields.push({ 
				kind: FVar(TPath( { name: "ILogger", pack:  [ "hex", "log" ], params: [] } ), null ), 
		meta: [ { name: "Inject", params: [], pos: Context.currentPos() }, { name: "Optional", params: [macro true], pos: Context.currentPos() }, { name: ":noCompletion", params: [], pos: Context.currentPos() } ], 
				name: "logger", 
				access: [ Access.APublic ],
				pos: Context.currentPos()
			});
		}
		
		
		var className = Context.getLocalClass().get().module;
		var loggerAnnotations = [ DebugAnnotation, InfoAnnotation, WarnAnnotation, ErrorAnnotation, FatalAnnotation ];

		for ( f in fields )
		{
			switch( f.kind )
			{
				case FFun( func ):
					
					var meta = f.meta.filter( function ( m ) { return loggerAnnotations.indexOf( m.name ) != -1; } );
					var isLoggable = meta.length > 0;
					if ( isLoggable ) 
					{
						if ( f.name == "new" )
						{
							Context.error( "log metadata is forbidden on constructor", f.pos );
						}
					
						#if debug
						var logSetting =  LoggableBuilder._getParameters( meta );
						
						var methArgs : Array<Expr> = [];
						var argsMsg : Array<String> = [];
						var expressions = [ macro @:mergeBlock { } ];
						var argPlaceholer = "='{}'";
						
						if ( logSetting.arg == null )
						{
							func.args.map(function(arg){
								argsMsg.push($v{arg.name} + argPlaceholer);
								methArgs.push(macro @:pos(f.pos) $i { arg.name });
							});
						}
						else
						{
							var printer = new Printer();
							logSetting.arg.map(function(arg){
								argsMsg.push($v{printer.printExpr(arg)} + argPlaceholer);
								methArgs.push(macro @:pos(f.pos) $arg);
							});
						}
						
						//
						var message = logSetting.message;
						var debugArgs = [];
						if ( message == null )
						{
							message = "{}(" + argsMsg.join(", ") + ")";
							debugArgs = [ macro @:pos(f.pos) $v { f.name } ].concat( methArgs );
						}
						else
						{
							if(logSetting.includeArgs && argsMsg != null)
							{
								message += " [" + argsMsg.join(", ") + "]";
							}
							debugArgs = methArgs;
						}
						var methodName = meta[ 0 ].name.toLowerCase();
		
						var body = macro @:pos(f.pos) @:mergeBlock
						{
							if ( logger == null ) logger = ${hex.log.HexLog.getLoggerCall()};
							logger.$methodName( $v{ message }, [ $a { debugArgs } ] );
						};

						expressions.push( body );
						expressions.push( func.expr );
						func.expr = macro @:pos(f.pos) $b { expressions };
						#end
						
						for ( m in meta )
						{
							if ( loggerAnnotations.indexOf( m.name ) != -1 )
							{
								f.meta.remove( m );
							}
						}
					}
					
				case _:
			}
			
		}
		
		return FastAnnotationReader.reflect( macro hex.di.IInjectorContainer, fields );
	}
	
	static function _getParameters( meta : Metadata ) : LogSetting
	{
		for ( m in meta )
		{
			var params = m.params;
			if ( params.length > 1 )
			{
				Context.warning( "Only one argument is allowed", m.pos );
			}
			
			for ( p in params )
			{
				var e = switch( p.expr )
				{
					case EObjectDecl( o ):
						
						var logSetting = new LogSetting();
						
						for ( f in o )
						{
							switch( f.field )
							{
								case "msg":
									switch( f.expr.expr )
									{
										case EConst( CString( s ) ):
											logSetting.message = s;

										case _: null;
									}
									
								case "arg":
									switch( f.expr.expr )
									{
										case EArrayDecl( a ):
											logSetting.arg = a;

										case _: null;
									}
								case "includeArgs":
									switch( f.expr.expr )
									{
										case EConst( CIdent( s ) ):
											logSetting.includeArgs = (s == "true");

										case _: null;
									}
								case _: null;
							}
						}

						
					
						return logSetting;
						
					case _: null;
				}
				
				//
			}
		}
		return new LogSetting();
	}
#end
}

private class LogSetting
{
	public function new(){}
	public var message 		: String;
	public var arg 			: Array<Expr>;
	public var includeArgs	: Bool;
}