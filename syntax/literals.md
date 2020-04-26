# Literals
### Int
An integer literal:
```
5
-2
2e3
```

Hex/binary literals are TBD.

### Dec
A floating-point literal:
```
+1.2
.3
4e-5
```

NaN and infinity literals are TBD.

### Char (TBD)
A unicode character literal:
```
#"a"
#"\n"
#"\x1b"
```

Chars support basic integer math such as `#"a" + 1` resulting in `#"b"`.

### Str
A string literal:
```
"hello!"
"not very \" mind-blowing tbh\n"
```

Expression interop is also supported using `\(...)` so:
```
"1 + 2 = \(1 + 2)"
```
becomes:
```
"1 + 2 = 3"
```

Strings are completely mutable.

Basic indexing looks like `"abc"[at: 1]` (which results in `#"b"`).

Multiline strings are TBD, but for now normal strings will probably be allowed to span multiple lines on their own.

### Bool
A boolean (logical) literal:
```
true
false
```

Booleans support logical operations such as: `!a` (not), `a && b` (and), `a || b` (or), and `a ^^ b` (xor). Might add an "nor" operator in the future.

### Array
An array literal:
```
#[1, 2, 3]
#[
	"a"
	"bcd"
	"ef"
	"ghij"
]
#[
	#[1.2, 3.4],
	#[5, 6]
]
```

Arrays may only contain 1 type of value. If its elements all conform to the same protocol(s), they will not be implicitly converted because of reasons (which may change eventually):
```
#[1, 2.3]             ;=> error!
#[1[Real], 2.3[Real]] ;=> works
```

Arrays are completely mutable.

Basic indexing looks like `#[1, 2, 3][at: 1]` (which results in `2`).

An array's type looks like `Array[E]` where `E` is the type of each value.

The type of an empty array without any sort of type indication is TBD.

### Hash
An associative array literal:
```
#("a" => 1, "b" => 2)
#(
	1 => 2.3
	4 => 56.7
	8 => 9.0
)
```

`l => r` are pair literals where `l` is the key and `r` is the value.

A literal on the left-hand side of a pair does not become a string, so keep that in mind.

Hashes are completely mutable.

Hashes are currently planned to be ordered (as opposed to being unordered).

Basic lookup looks like `#("a" => 1, "b" => 2, "c" => 3)[at: "b"]` (which results in `3`).

A hash's type looks like `Hash[K, V]` where `K` is the type of every key and `V` is the type of every value.

The type of an empty hash without any sort of type indication is TBD.

### Tuple (TBD)
A tuple literal:
```
#{1, 2.3, "4"}
```

Everything else is TBD.

### Func
An anonymous function literal:
```
{|| thing[doStuff]}
{|a, b| return a + b}
{|val (SomeType)| (SomeOtherType)
	val[doThing]
	return val[SomeOtherType]
}
```

Funcs may not have custom labels when called.

Funcs do not implicitly return.

If a func doesn't return anything, its return type is `Void`.

Funcs are called like `{|a, b| return a + b}[call: 1, 2]` (which results in `3`).

A Func's type looks like `Func[Ret, Args...]` where `Ret` is the func's return type and `Args...` are types of all of its arguments.

### Func (shorthand) (TBD-ish)
Funcs also support a shorthand for single-expression funcs.

`$0 + $1` is the same as `{|a, b| return a + b}`.

`$0.0 + $0.1` is the same as `{|a| return {|b| return a + b}}`.

`val[thing: $0 + 1]` is not the same as `{|a| return val[thing: a + 1]}`, but instead `val[thing: {|a| return a + 1}]`.

A way to have `val[thing: $0 + 1]` mean the same thing as `{|a| return val[thing: a + 1]}` is TBD.

Shorthand funcs are most likely going to be very limited until Star has a good type-checker.

### Name
A name literal:
```
abc
d
ef_g
thing122
_1
```

Names cannot only be an underscore.

Names cannot start with an uppercase letter.

Identifiers, keywords, tags, and macro variables follow this convention.

### Type
A type literal
```
MyType
Core.Int
LLVM.Ptr[Void]
_
```

Type names must start with an uppercase letter.

A type name only containing an underscore is a special case that will be explained at some point later.

A type may contain multiple type names separated by a `.`. `A.B.C` identifies a type called `C` located in `A.B`.

A type may be generic if allowed, in which case it's followed by 1 or more types separated by a `,` within a `[...]`.

Modules, classes, protocols, categories, kinds, aliases, and type parameters follow this convention.

### Label
A label literal:
```
a:
bcd:
_1:
e_:
_:
```

Labels start with a lowercase letter or an underscore.

Label syntax may be reversed as `:something` in the case of `something: something` in a method call.

### Tag
A tag literal:
```
#a
#something
#b_2c
```

Tags are annotations for expressions and they'll probably be removed at some point in the future.

### Litsym
A litsym literal:
```
`a`
`some symbol`
`a[b]c`
```

Litsyms are compile-time strings that are also used for internal stuff.

### Paren
A paren literal:
```
(1 + 2) * 3
(4, 5, 6)
```

Multiple expressions in a paren will evaluate each expression consecutively and return the final expression as the result.

### Group
A group literal:
```
[...]
```

Generally not used by itself, but it represents a list of abstract syntax nodes.

### Block
A block literal:
```
{...}
```

Represents consecutive statements in a context.