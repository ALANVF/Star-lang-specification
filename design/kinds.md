### Value kinds

Kinds are what most languages call an enum or discriminated union (although really they can be either).
Here's a simple example:
```scala
kind Fruit {
	has apple
	has mango
	has banana
}

my fruit = Fruit.mango
Core[say: fruit]       ;=> Fruit.mango
fruit = Fruit.banana
Core[say: fruit]       ;=> Fruit.banana
```

Regular kinds like this are similar to C-style enums, and they can be compared and also support basic math.
```scala
Core[say: Fruit.banana > Fruit.apple] ;=> true
Core[say: Fruit.mango[previous]]      ;=> Fruit.apple
```


### Base type

Kinds can also be typed, where its members represent a value of the specified type.
```scala
kind Sign (Int) {
	has negative => -1
	has positive => 1
}

Core[say: Sign.negative]           ;=> Sign.negative
Core[say: Sign.negative.value]     ;=> -1
Core[say: 5 * Sign.negative.value] ;=> -5
```


### Tagged kinds

Now for the fun stuff!
(some of this stuff is also covered in the pattern matching concept).

Star also allows kinds to act like tagged unions.
```scala
kind Number {
	has [zero]
	has [nth: (Int)]
}

Core[say: Number[zero]]   ;=> Number[zero]
Core[say: Number[nth: 1]] ;=> Number[nth: 1]
```

They can also be matched on.
```scala
my num = Number[nth: 2]

match num {
	at Number[zero] => Core[say: "zero"]
	at Number[nth: 1] => Core[say: "one"]
	at Number[nth: my n] => Core[say: n]
} ;=> 2
```

You can also have kinds that have type parameters.
```scala
type T
kind Option[T] {
	has [some: (T)]
	has [none]
}

my opt1 = Option[some: "thing"] ; Option[Str]
my opt2 = Option[some: 2.3]     ; Option[Dec]
```


### Members

Kinds may have static/instance members:
```scala
kind Token {
	my position (Int)

	has [this]
	has [int: (Int)]
	has [assign: (Expr) to: (Expr)]
}

my thisToken = Token[this]
-> position = 1 ;-- We can't pass `position:` as a parameter because `this` takes no args

my intToken = Token[int: 123 position: 8]

my assignToken = Token[assign: thisToken to: intToken position: 6]

Core[say: assignToken.position] ;=> 6
```


It should be worth noting that value kinds (as opposed to tagged kinds) currently aren't allowed to have instance members.
This restriction may be lifted in the future.


### Inheritance

Unlike most languages, Star allows kinds to inherit from types.

In particular, kinds may inherit from other kinds, which is not allowed in other languages for whatever reason.
When this happens, the hierarchy becomes flipped, where the supertype is always compatable with the subtype, but the opposite is not always true.
```scala
kind Parent {
	has a
	has b
}

kind Child of Parent {
	has c
}

my value1 = Child.c
my value2 = Child.b

Core
-> [say: value1[Parent]] ;=> error!
-> [say: value2[Parent]] ;=> Parent.b
```

Since tagged kinds also support inheritance, you can emulate what some might use GADTs for in a language like OCaml by using the polymorphic `This` type:
```scala
kind Expr {
	has [int: (Int)]
	has [add: (This), (This)]
}

kind TypedExpr of Expr {
	has [type: (Type) ctor: (Array[This])]
}

my expr = Expr[add: Expr[int: 1], Expr[int: 2]]
my texpr = expr[TypedExpr] ;=> TypedExpr[add: TypedExpr[int: 1], TypedExpr[int: 2]]
```

### Multi-kinds

Multi-kinds are similar to bitflags, which are common in languages like C/C++ and Go.

#### Value multi-kinds

Value multi-kinds are most similar to actual bitflags, except they do not necessarily need to be integers and they are strongly typed.

```scala
kind Foo is flags {
	has default
	has a
	has b
	has c
}

my foo = Foo.a | Foo.c
```
The first tag is always the default value, although this will likely be configurable in the near future.

They can be tested and pattern matched on as well
```scala
if foo & bar ?= Foo.b { ... }  ;-- check if `foo` and `bar` both have `Foo.b`
if foo & ~Foo.c ?= foo { ... } ;-- check if `foo` does not have `Foo.c`

match foo {
	at Foo.a & my foo' { ... } ;-- check if `foo` has `Foo.a`, so now `foo'` is `foo ^ Foo.a`
	at _ ^ Foo.c { ... }       ;-- check if `foo` does not have `Foo.c`
	at Foo.b { ... }           ;-- check if `foo` is `Foo.b` exactly
	at Foo.default { ... }     ;-- check if `foo` is empty
}
```

#### Tagged multi-kinds

Multi-kinds can also be used for tagged kinds:
```scala
kind Foo is flags {
	has [default]
	has [a]
	has [b: (Int)]
	has [c: (Str) d: (Str)]
}

my foo = Foo[a] | Foo[c: "abc" d: "def"]
```
The first tag is always the default value, although this will likely be configurable in the near future.

Like value multi kinds, they also support pattern matching, which is where their true power shines:
```scala
match foo {
	at Foo[a] & my foo' { ... }  ;-- check if `foo` has `Foo[a]`, so now `foo'` is `foo ^ Foo[a]`
	at _ ^ Foo[b: _ < 5] { ... } ;-- check if `foo` does not have `Foo[b: my b]` where `b` is less than 5
	at Foo[c: _ d: "b"] { ... }  ;-- check if `foo` is exactly `Foo[c: _ d: my d]` where `d` is the string `"b"`
	at Foo[default] { ... }      ;-- check if `foo` is empty
}
```

Unlike value multi-kinds, tagged multi-kinds cannot be inverted using the `~` operator.

Unlike normal tagged kinds, tagged multi-kind cannot have fields due to their composition-based nature. This may be looked at again in the future

<br>

Multi-kinds (both value and tagged) also support inheritance, and even multiple inheritance. This can be helpful if you have something like a subset of options that also need to all be generalized together.
```scala
kind A is flags {
	has default
	has a
	has b
}

kind B is flags {
	has default
	has c
	has d
}

kind C of A, B is flags {
	has e
}
```

Do note that there will be no implicit coercion from parent to child type in this situation, so something like `C.e | B.d` will error (you should instead do `C.e | C.d`).

### Why?

Because I think that by removing the distinction between variants and classes, we can discover new and better ways to represent and structure data.

Why *shouldn't* variants be allowed to have methods?

Why *shouldn't* variants be allowed to have unified properties?

Why *shouldn't* variants be allowed to implement interfaces and extend classes?

Why *shouldn't* variants be allowed to inherit other variants??

The answer to all of these questions is that there **is no good reason**, so these restrictions should be lifted in order to give the programmer more power and make the language more complete.


TODO:
- multi-kinds