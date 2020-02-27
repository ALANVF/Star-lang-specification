(this will closely relate to the macros document that I'll make later)

# Syntax is data?
Yes. Similarly to languages such as Lisp (and variants), REBOL/Red, and Crystal (to an extent), all syntax in Star is actually data. here's a small example:
```swift
macro [whatIsThis: thing (AST.Literal)] {
	say[@(thing[astName])]
}

[whatIsThis: "banana"] ;=> "AST.String"
[whatIsThis: label:]   ;=> "AST.Label"
[whatIsThis: thing]    ;=> "AST.Name"
```

This is similar to Lisp languages, where macros can manipulate the data passed to them like (idk lisp too well)
```nu
(macro dyn-set (name val) `(set ,name val))
```

or like REBOL/Red, where you can pretty much do anything with anything such as
```red
unpack: func [
	names [series!]
	value [series!]
][
	forall value [
		set names/(index? value) value/1
	]
]

unpack [a b c] [5 1.2 "banana"] ;=> a: 5, b: 1.2, c: "banana"
```

# The AST types
(note: all of this is going to change soon)
```yaml
- AST:
    - Literal:
        - Name: a valid variable name.
        - Type: a valid type name.
        - Label: a valid label. note that single labels are a Name.
        - Integer: a whole number.
        - Decimal: a rational.
        - String: a string.
        - Boolean: a boolean.
        - Operator: an operator literal. this does not include (), [], nor {}.
        - Symbol: a symbol literal (looks like "`symbol`" btw).
        - Array: an array literal.
        - Hash: a hash literal.
        - Func: a function literal.
    - Compound:
        - Paren: an expression inside ().
        - Call: any message call.
        - DirectCall: a message call explicitly sent to an object.
        - ContextCall: a message call implicitly sent to the current context object.
        - NamePath: a variable identifier that can be accessing a member (like myPoint.x).
        - TypePath: a type identifier that can be inside a module (like Core.Int).
    - Meta:
        - Body: a series of AST nodes inside []. may change the name.
        - Block: a series of statements inside {}.
        - Sep: a `,` or newline.
        - Punct: any single symbol.
    - AnyLiteral: any literal.
    - AnyCompound: any compound.
    - AnyValue: any literal or compound.
    - AnyExpr: any valid Star expression.
    - Statement: a valid Star statement.
    - Any: any AST node. probably dangerous.
```
