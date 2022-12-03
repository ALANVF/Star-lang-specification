### Use statement
Imports a module, category, or type into the current namespace.

Spec:
```antlr
use-tree ::=
	| <type>
	| <array(of: <type>)>
	| <hash(key: <type>, value: <use-tree>)>

use-stmt ::=
	<leading-type-vars>
	'use' (
		| <litsym>
		| <use-tree> ( 'from:' <type> | <string> )? ( 'as:' <use-tree> )?
	)
```

Examples:
```star
use Core
use #[A, B] from: C
use #(
	A => B
	C => #[D, E]
	F => #(
		G => H
	)
)
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