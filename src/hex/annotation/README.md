# IAnnotationReplace

*Currently as minimum viable product*

Utility interface that allows you to replace expressions in annotation with their values. It's especially handy for keeping injection names in classes with constants.

Build macro attached to `IAnnotationReplace` will cause following change:

```haxe
@Inject(MyConstants.NAME_ONE)
public var injectedOne:String;
```

becomes

```haxe
@Inject("one")
public var injectedOne:String;
```

Expressions that are already constants wil remain unouched so `@Inject("one")` will stay the same. That also applies for combinations of expressions so `@Inject(MyConstants.NAME_ONE, "two")` changes to `@Inject("one", "two")`

Currently supported values of expressions:
- String
- Bool
- Int

**Important: If used with `IInjectorContainer` the order matters:**

Only this order of implementation will work because of the macro execution order - fix will come soon:

`class MyClass implements IInjectorContainer implements IAnnotationReplace `
