### Use statement
Imports a module, category, or type into the current namespace.

Spec:
```antlr
use-stmt ::=
	'use' <type> ( 'only:' ( <type> | <group> ) )? ( 'as:' <type> )?
```

Examples:
```
use Core
use Thing1 as: Thing2
use A only: [B, C] as: D
```

Notes:
- `only:`/`as:` syntax will probably change at some point.

### Member declaration
A member declaration.

Spec:
```antlr
attribute ::=
	| 'static'            // Not valid inside a module
	| 'hidden'
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