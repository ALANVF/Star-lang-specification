# Method declarations
These are declarations that are valid when *not* inside a method definition or at the top-level.

Common rules:
```antlr
type-anno ::=
	'(' <type> ')'

leading-type-vars ::=
	( <type-var-decl> <sep> )*

types-spec ::=
	| <type>
	| <array(of: <type>)>

body ::=
	| '=>' <simple-stmt>
	| <block(of: <stmt>)>
```

General Notes:
- Shorthand method bodies (`=> stmt`) are required to be a simple statement or expression (so no control flow, etc).
- Overloading based on return type is not a thing.
	- Likewise, the return type cannot be an unbound type variable or typeclass (yet).
- Virtual methods can still be generic.
- There's no way to explicitly specify the generic types for a method call. Use a category if necessary.

### Default initializer
An initializer that runs when a value is constructed.

Spec:
```antlr
default-init ::=
	'init' <body>
```

### Global initializer
An initializer that runs at the start of a program.

Spec:
```antlr
global-init ::=
	'init' 'is' 'static' <body>
```

### Default deinitializer
A deinitializer that runs when a value is deconstructed.

Spec:
```antlr
default-deinit ::=
	'deinit' <body>
```

### Global deinitializer
A deinitializer that runs at the end of a program.

Spec:
```antlr
global-deinit ::=
	'deinit' 'is' 'static' <body>
```

### Method
A static or instance method.

Spec:
```antlr
attribute ::=
	| 'static'
	| 'hidden' <type>?
	| 'sealed' <type>?
	| 'main'
	| 'getter'
	| 'setter'
	| 'noinherit'
	| 'unordered'
	| 'native' <litsym>?
	| 'inline'
	| 'asm'
	| 'macro'

multi-sig ::=
	<label> <name>? <type-anno> ( '=' <expr> )?
	( ( <sep>? <label> | ',' ) <name>? <type-anno> ( '=' <expr> )? )*

method ::=
	<leading-type-vars>
	'on' '[' ( <name> | <multi-sig> | <type> ) ']' <type-anno>? ( 'is' <attribute> )* <body>?
```

Notes:
- Method names may be a keyword without causing any issues.
- Return type is required if the method returns something other than void.
- Redundant getters and setters will cause an error.
- Getters must not have side-effects\*.
- `unordered` requires every parameter to have a label.

### Initializers
A method that creates an instance of a type.

Spec:
```antlr
attribute ::=
	| 'hidden' <type>?
	| 'sealed' <type>?
	| 'noinherit'
	| 'unordered'
	| 'native' <litsym>?
	| 'asm'
	| 'macro'

init ::=
	<leading-type-vars>
	'init' '[' ( <name> | <multi-sig> ) ']' ( 'is' <attribute> )* <body>?
```

Notes:
- Initializer names may be a keyword without causing any issues.
- `unordered` requires every parameter to have a label.
- Yes, initializers can be generic.

### Operator overloads
An operator overload.

Spec:
```antlr
attribute ::=
	| 'hidden' <type>?
	| 'sealed' <type>?
	| 'noinherit'
	| 'native' <litsym>?
	| 'inline'
	| 'asm'
	| 'macro'

operator ::=
	<leading-type-vars>
	'operator' <litsym> ( '[' <name> <type-anno> ']' )? <type-anno> ( 'is' <attribute> )* <body>?
```

Notes:
- `&&`, `||`, `^^`, and `!!` overloads must be macros, and in general aren't really operator overloads.
- Operator overloads must not have side-effects\*.
- You cannot overload assignment ops.
- For relational ops:
	- RHS type must be compatible with `This`.
	- Return type must be boolean-like\*\*.
- For `!` and `?`:
	- Return type must be boolean-like\*\*.
- For `++` and `--`:
	- Cannot overload prefix and postfix separately.
	- Does not actually modify the caller, but returns a new value.
	- Return type must be compatible with `This`.
- `...` cannot (currently) be overloaded.

# Footnotes

\* throwing errors is fine, and maybe printing stuff could be allowed idk.

\*\* either a class with ``is native[repr: `bool`]``, or a newtype of such a class.