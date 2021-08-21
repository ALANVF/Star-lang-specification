# Top-level declarations
These are declarations that are valid when *not* inside a method definition.

Common rules:
```antlr
type-anno ::=
	'(' <type> ')'

leading-type-vars ::=
	( <type-var-decl> <sep> )*

parents ::=
	'of' <type> ( ',' <type> )*

types-spec ::=
	| <type>
	| <array(of: <type>)>
```

### Type variable declaration
Declares a type variable that will be relevant upto the next declaration (that isn't a type variable declaration).

Spec:
```antlr
cond ::=
	| '!' ( <cond> | <type> )
	| <type> '?'
	| <type> ( ( '<' | '>' | '<=' | '>=' ) <type> )+
	| <type> ( '?=' <type> )+
	| <type> ( '!=' <type> )+
	| <type> ( 'of' <type> )+
	| <cond> ( '&&' | '||' | '^^' | '!!' ) <cond>
	| '(' <cond> ')'                                 // allows the same "leading operator" thing as normal parens

attribute ::=
	| 'flags'
	| 'strong'
	| 'uncounted'
	| 'native' '[' ... ']'

type-var-decl ::=
	| 'type' <type> <parents>? ( 'is' <attribute> )* ( 'if' <cond> )? <block(of: <any-decl>)>?
	| 'type' <type> '=' <type>
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

type Stringy {
	on [Str]
}
```

Notes:
- Type variable declarations are not allowed to stand on their own; they must be part of a larger declaration.
- A type variable may be assigned to an alias for future use.
- Yes, higher-kinded types are permitted :)

### Type alias declaration
Spec:
```antlr
attribute ::=
	| 'hidden' <type>?
	| 'friend' <types-spec>
	| 'noinherit'

type-alias-decl ::=
	<leading-type-vars>
	'alias' <type> (
		| ( 'is' <attribute> )* '=' <type>
		| ( '(' <type> ')' )? ( 'is' <attribute> )* <block(of: <decl>)>?
	)
```

Examples:
```antlr
alias Float = Dec
alias Name (Str)
```

Notes:
- If a type variable appears on the RHS of a direct alias, the alias becomes a [typeclass](https://en.wikipedia.org/wiki/Type_class).
- `noinherit` is only valid for newtypes

### Class declaration
Spec:
```antlr
attribute ::=
	| 'hidden' <type>?
	| 'friend' <types-spec>
	| 'sealed' <type>?
	| 'strong'
	| 'uncounted'
	| 'native' '[' ... ']'

class-decl ::=
	<leading-type-vars>
	'class' <type> <parents>? ( 'is' <attribute> )* <block(of: <decl>)>
```

Examples: Anything in `examples`.

### Protocol declaration
Protocols are a combination of interfaces and traits that use dynamic-dispatch for method calls.

Spec:
```antlr
attribute ::=
	| 'hidden' <type>?
	| 'friend' <types-spec>
	| 'sealed' <type>?

class-decl ::=
	<leading-type-vars>
	'protocol' <type> <parents>? ( 'is' <attribute> )* <block(of: <decl>)>
```

### Category declaration
[Details](../concepts/categories/categories.md)

Spec:
```antlr
attribute ::=
	| 'hidden' <type>?
	| 'friend' <types-spec>

category-decl ::=
	<leading-type-vars>
	'category' <type> ( 'for' <type> )? ( 'is' <attribute> )* <block(of: <decl>)>
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
	| 'hidden' <type>?
	| 'friend' <types-spec>
	| 'sealed' <type>?
	| 'strong'
	| 'uncounted'
	| 'flags'

has-stmt ::=
	| 'has' <name> ( '=>' <expr> )? <block>?
	| 'has' '[' ( <multi-sig> | <name> ) ']' ( '=>' <message> )? <block>?

kind-decl ::=
	<leading-type-vars>
	'kind' <type> <type-anno>? <parents>? ( 'is' <attribute> )* <block(of:
		| <decl>
		| <has-stmt>
	)>
```

Notes:
- Kinds are allowed to inherit from other kinds, unlike every other programming language in existence.

[More about kinds](../design/kinds.md)

### Module declaration
Spec:
```antlr
attribute ::=
	| 'hidden' <type>?
	| 'friend' <types-spec>
	| 'sealed' <type>?
	| 'main'
	| 'native' <litsym>?

module-decl ::=
	<leading-type-vars>
	'module' <type> <parents>? ( 'is' <attribute> )* <block(of: <decl>)>
```