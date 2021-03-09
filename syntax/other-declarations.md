### Use statement
Imports a module, category, or type into the current namespace.

Spec:
```antlr
use-stmt ::=
	'use' ( <type> | <array(of: <type>)> ) ( 'from:' <type> )?
```

Examples:
```
use Core
use #[A, B] from: C
```

### Member declaration
A member declaration.

Spec:
```antlr
attribute ::=
	| 'static'            // Not valid inside a module
	| 'hidden' <type>?
	| 'readonly'
	| 'getter'
	| 'setter'
	| 'noinherit'         // Only valid within an inheritable type
	| 'native' (          // Only valid within a native module
		| <string>
		| '[' ... ']'
	)?

member-decl ::=
	'my' <name> <type-anno>? ( 'is' <attribute> )* ( '=' <expr> )?
```

### More to come later...