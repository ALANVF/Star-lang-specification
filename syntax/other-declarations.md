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

### Member declaration
A member declaration.

Spec:
```antlr
attribute ::=
	| 'static'            // Not valid inside a module
	| 'hidden'
	| 'readonly'
	| 'writeonly'         // will be removed in the future (only here for completion)
	| 'getter'
	| 'setter'
	| 'custom'            // might be removed in the future
	| 'noinherit'         // Only valid within a class or protocol. might be removed in the future
	| 'native' (          // Only valid within a native module
		| <litsym>
		| <group>
	)?

member-decl ::=
	'my' <name> <type-anno>? ( 'is' <attribute> )* ( '=' <expr> )?
```

### More to come later...