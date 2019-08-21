# Classes

Everything in Star is a class
```swift
1[what]       ;=> "Int"
"thing"[what] ;=> "Str"
{||}[what]    ;=> "Func(Void)"
```

### Class basics

A basic class
```swift
class Point {
	my x (Int)
	my y (Int)
}

say[Point[x: 1, y: 2]] ;=> "Point[x: 1 y: 2]"
```

Notice that I did not need to declare an initializer. Star provides automatic initializers for classes based on the member variables (can be turned off with option I'll decide on later).

For the class `Point`, the following initializers are automatically created:
```swift
init [new]                             {...}
init [x: (Int)]                        {...}
init [y: (Int)]                        {...}
init [x: (Int), y: (Int)] is unordered {...}
```

Just like with normal variables, class/member variables are not required to be assigned a value as long as you explicitly declare its type, or you assign it a default value. As an example, the following would be invalid:
```swift
class Point {
	my x
	my y
}

Point[x: 1]
```

This is invalid because `y` is never assigned a value, so the compiler doesn't know what its type is.

### Member basics

Using the previously defined `Point` class, we can access/assign the `x` and `y` members like this:
```swift
my p = Point[x: 1, y: 2]
say[p.x] ;=> 1
p.y = 3
say[p.y] ;=> 3
```

### Message basics

Star uses messaging instead of methods, which are similar but not the same. In a normal language, you may do something like this:
```js
"abacad".replace("a", "_") //=> "_b_c_d"
```

But in Star, you'd do this instead:
```swift
"abacad"[replace: "a" with: "_"] ;=> "_b_c_d"
```

Messaging is kinda like calling unnamed methods with named arguments I guess. Star does allow you to have arguments without labels, but you must remember these rules:
- labeled arguments do not need to (but can) have a separator (`,` or newline) between them.
- arguments must end with a separator if the next argument is unnamed.
- a message is allowed to only have a label (like `1[abs]`), but no other labels/arguments are allowed in the rest of the call.
- all messages must have at least one label.

You should also note these other rules regarding messaging:
- you may send a message to an object like `a[b: c]` or `[a b: c]`.
- (for now) you may not have any space between the caller and the brackets `[]` when using prefix notation (`a[b: c]`).
- you may send a message to the current context (class or module) by doing `[a: b c: d]` or `a[b c: d]`.
- you may not have a variable share the same name as the first label of a message sent to the current context (e.g. `a[b]` could either be `[this a: b]` or `[a b]`).
- a message call to the current context with a single label may be called like `thing[]` or `[thing]`.

(put something here about type messages smh)

As a side note, messaging in Star works like Swift, where the following happens:
```swift
on [whatIsThis: (Int)] {
	return "integer"
}

on [whatIsThis: (Dec)] {
	return "decimal"
}

say[whatIsThis[1]]   ;=> "integer"
say[whatIsThis[2.3]] ;=> "decimal"
```

# Syntax

(specs for attributes will be discussed later)

The syntax to declare a class:
```less
"class" <type> ("of" <type> ("," <type>)*)? ("is" <class-attr>)* "{"
	(
		| <use-statement>
		| <var-statement>
		| <init-statement>     // static message that creates a class
		| <on-statement>       // regular message call
		| <operator-statement> // will be discussed later
		| <macro-statement>    // will be discussed ... at some point
		| <class-statement>    // maybe
		| <module-statement>   // maybe
	)*
"}"
```

The syntax to declare a message:
```less
"on" "["
(
	| <type>
	| <single-label>
	| (
		| <label> <name> <type-anno>?
		| <label> <type-anno>?
		| <name> <type-anno>?
	)+
)
"]" <type-anno>? ("is" <message-attr>)* "{" ... "}"
```

Class attributes:
- `hidden`: only allow this class to be used by the outer class.

Message attributes:
- `static`: send this message to the class itself.
- `hidden`: only allow this message to be sent inside the class.
- `unordered`: order of the arguments don't matter (cannot have any unnamed arguments).