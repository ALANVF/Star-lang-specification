# Namespace declarations
These are declarations that are valid when *not* inside a method definition.

Common rules:
```antlr
type-anno ::=
	'(' <type> ')'

leading-type-args ::=
	( <type-arg-decl> <sep> )*

parents ::=
	'of' <type> ( ',' <type> )*
```

Notes:
- Not permitted within values-based kinds.
- Not permitted within categories.
- Not permitted at the top-level.

### Type argument declaration
Declares a type argument that will be relevant upto the next declaration (that isn't a type argument declaration).

Spec:
```antlr
cond ::=
	| <type> ( '?=' | '!=' | 'of' ) <type>
	| <cond> ( '&&' | '||' | '^^' ) <cond>
	| '!' <cond>
	| '(' <cond> ')'


type-arg-decl ::=
	'type' <type> <parents>? ( 'if' <cond> )?
```

Examples:
```
type T
...

type K of Hashable
type V
...

type E if E != Void
...

type I of Sequential, Comparable
type A of Positional[I]
...

type HKT[_, Int]
...
```

Notes:
- Type argument declarations are not allowed to stand on their own; they must be part of a larger declaration.
- Yes, higher-kinded types are permitted :)

### Type alias declaration
Spec:
```antlr
attribute ::=
	| 'hidden'

type-alias-decl ::=
	<leading-type-args>
	'type' <type> ( 'is' <attribute> )* '=' <type>
```

Examples:
```antlr
type Float = Dec
```

Notes:
- Type arguments are not required to appear on the RHS of the declaration.

### Class declaration
Spec:
```antlr
attribute ::=
	| 'hidden'
	| 'c_struct'
	| 'c_union'
	| 'uncounted'
	| 'strong'                // Maybe
	| 'native' <group>

class-decl ::=
	<leading-type-args>
	'class' <type> <parents>? ( 'is' <attribute> )* <block(of: <decl>)>
```

Examples: Anything in `examples`.

### Protocol declaration
Protocols are a combination of interfaces and traits that use dynamic-dispatch for method calls.

Spec:
```antlr
attribute ::=
	| 'hidden'

class-decl ::=
	<leading-type-args>
	'protocol' <type> <parents>? ( 'is' <attribute> )* <block(of: <decl>)>
```

### Category declaration
[Details](../concepts/categories/categories.md)

Spec:
```antlr
attribute ::=
	| 'hidden'

category-decl ::=
	<leading-type-args>
	'category' <type> 'for' <type> ( 'is' <attribute> )* <block(of: <decl>)>
```

Examples:

[here](../concepts/categories/Fractions/Int+Fractions.star)

[here](../concepts/categories/Fractions/Dec+Fractions.star)

[here](../concepts/categories/Fractions/Real+Fractions.star)

### Kind declaration
Not to be confused with [higher-kinded types](https://en.wikipedia.org/wiki/Kind_(type_theory)), kinds are commonly known as "enums" or "variants" in other languages.

Spec:
```antlr
attribute ::=
	| 'hidden'
	| 'c_enum'
	| 'flags'

kind-decl ::=
	<leading-type-args>
	'kind' <type> <type-anno>? <parents>? ( 'is' <attribute> )* <block(of:
		| TODO
	)>
```

[Examples](../concepts/kinds/kinds.md)

Notes:
- This is going to take a while to finish the spec for. Just look at the [concept](../concepts/kinds/kinds.md) for now (pls).

### Module declaration
Spec:
```antlr
attribute ::=
	| 'hidden'
	| 'main'
	| 'native' (
		| <string>
		| <group>
	)?

module-decl ::=
	'module' <type> ( 'is' <attribute> )* <block(of: <decl>)>
```