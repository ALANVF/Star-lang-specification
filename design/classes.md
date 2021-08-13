(NOTE: some things in here are a bit outdated)

### Class basics

A basic class
```scala
class Point {
	my x (Int)
	my y (Int)
}

Core[say: Point[x: 1, y: 2]] ;=> "Point[x: 1 y: 2]"
```

Notice that I did not need to declare an initializer. Star provides automatic initializers for classes based on the member variables (can be turned off with an option I'll decide on later).

For the class `Point`, the following initializers are automatically created:
```swift
init [new]                {...}
init [x: (Int)]           {...}
init [y: (Int)]           {...}
init [x: (Int), y: (Int)] {...}
```

Just like with normal variables, class/member variables are not required to be assigned a value as long as you explicitly declare its type, or you assign it a default value. As an example, the following would be invalid:
```scala
class Point {
	my x
	my y
}

Point[x: 1]
```

This is invalid because `y` is never assigned a value, so the compiler doesn't know what its type is.

### Member basics

Using the previously defined `Point` class, we can access/assign the `x` and `y` members like this:
```scala
my p = Point[x: 1, y: 2]
Core[say: p.x] ;=> 1
p.y = 3
Core[say: p.y] ;=> 3
```

### Message basics

Star uses messaging instead of methods, which are similar but not the same. In a normal language, you might do something like this:
```js
"abacad".replace("a", "_") //=> "_b_c_d"
```

But in Star, you'd do this instead:
```scala
"abacad"[replace: "a" with: "_"] ;=> "_b_c_d"
```

Messaging is kinda like calling unnamed methods with named arguments I guess. Star does allow you to have arguments without labels, but you must remember these rules:
- labeled arguments do not need to (but can) have a separator (`,` or newline) between them.
- arguments must end with a separator if the next argument is unlabeled (i.e a value without a label).
- a message is able to only have a single label (like `1[abs]`), but no other labels/arguments are allowed in the rest of the call.
- all messages must have at least one label.

You should also note these other rules regarding messaging:
- you may send a message to an object like `a[b: c]` or `[a b: c]`.
- (for now) you may not have any space between the caller and the brackets `[]` when using prefix notation (`a[b: c]`).

(put something here about casting smh)

As a side note, messaging in Star works like Swift, where the following happens:
```scala
on [whatIsThis: (Int)] (Str) {
	return "integer"
}

on [whatIsThis: (Dec)] (Str) {
	return "decimal"
}

Core[say: this[whatIsThis: 1]]   ;=> "integer"
Core[say: this[whatIsThis: 2.3]] ;=> "decimal"
```

# Syntax

(NOTE: this is kinda old. please look at [the actual spec](../syntax/other-declarations.md) instead)

The syntax to declare a class:
```less
"class" <type> ("of" <type> ("," <type>)*)? ("is" <class-attr>)* "{"
	(
		| <use-statement>
		| <var-statement>
		| <init-statement>     // static message that creates a class
		| <deinit-statement>   // called before arc destroys a class instance
		| <on-statement>       // regular message call
		| <operator-statement> // will be discussed later
		| <macro-statement>    // will be discussed ... at some point
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
- `hidden`: only allow this class to be used by the namespace that it's contained in, along with optional specified types.
- ~~`c_struct`: represents a native C struct (so it doesn't have any RTTI).~~
- ~~`c_union`: I think you can figure it out.~~
- `uncounted`: disable ref counting and other forms of automatic memory management. you generally shouldn't need this.
- `strong`: the destructor doesn't need to check for cycles when deallocating members.
- `native`: declares the class to represent a native type. note that it's still fully capable of behaving like a class.
- `friend`: similar to `friend` in c++.
- `sealed`: cannot be extended outside of the file, except for an option specified type.

Message attributes:
- `static`: send this method to the class itself.
- `hidden`: only allow this method to be sent inside the class, along with optional specified types.
- `unordered`: order of the arguments don't matter (cannot have any unlabeled arguments).
- `getter`: the method may be called as if it were a member. the method must not take any values.
- `setter`: the method may be called as if it were assigning a value to a member. if there is more than 1 argument, it becomes a setter method (e.g `a[b: c] = d`).
- `main`: this is the method to be called when running the main program. must be inside the main module.
- `noinherit`: subclasses do not inherit this message.
- `native`: the method represents a native function (details coming soon).
- `inline`: exactly what it sounds like.
- `asm`: allows the direct use of raw Star IR via tag expressions.
- `macro`: a macro-method. can be a static or instance method, however macro-methods cannot be virtual.
- `sealed`: cannot be overridden outside of the type, except for an option specified type.