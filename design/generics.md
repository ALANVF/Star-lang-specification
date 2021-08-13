## A quick peek

```swift
type T
class Box[T] {
	my value (T)
}

my box1 = Box[Int][value: 1]
my box2 = Box[Dec][value: 2.3]
```

## Generics
Similarly to C++, Star uses "templates" for generic structures. In the above example, `T` becomes a type variable for the class `Box` (and then disappears afterwards),
which takes `T` as a type argument. Type arguments can usually be inferred in expressions, but should have explicit args when used elsewhere (because it otherwise becomes a higher-kinded type):

```swift
type T
class Box[T] {
	my value (T)
}

my box1 = Box[Int][value: 1] ;=> Box[Int]
my box2 = Box[value: 2.3]    ;=> Box[Dec]
my box3 = Box[new]           ;=> Box[_]
```

## Influence from C++
Unlike most languages with generics, Star lets you overload generic structures using something called template specialization, which is
a concept from C++. If you aren't already familiar with template specialization, here's a basic example in C++ (or just google it lol):

```c++
template<typename T>
void func(vector<T> vec) {puts("passed a generic vector value");}

template<typename T>
void func(T scalar) {puts("passed a generic scalar value");}

// ...

func(1);               //=> passed a generic scalar value
func(vector<int> {1}); //=> passed a generic vector value
```

One example of why this might be useful is for implementing something such as a transposition method for an array type. Instead of
[assuming that the array's type is also an array](https://github.com/crystal-lang/crystal/blob/533cd24089860d7bdf089484aae71f0c60441d3b/src/array.cr#L1911), we could
implement the `transpose` method for `Array[Array[T]]` but leave it out for `Array[T]`. The reason this works it because the generic
parameters for `Array[Array[T]]` are more specific than the generic parameters for `Array[T]`. Here's an example of how this could work:

```scala
type T
class Array[T] {
	; note that [transpose] does not exist here
}

type T
class Array[Array[T]] {
	on [transpose] {...}
}

#[1, 2, 3, 4][transpose]       ;=> error: instance of type Array[Int] has no method `[transpose]`!
#[#[1, 2], #[3, 4]][transpose] ;=> #[#[1, 3], #[2, 4]]
```

As a side note, refinements of a type do not need to provide the parents or attributes of the base type unless they differ.
Overloads, however, do require these things as they are separate types.

## Generic constraints
Kinda self-explainitory:
```scala
; ...
type T of Num
on [doThing: val (T)] => Core[say: val]
; ...
this[doThing: 1]   ;=> works
this[doThing: 2.3] ;=> works
this[doThing: "a"] ;=> fails: type `Str` does not conform to protocol `Num`
```

Refinement types also exist:
```scala
type T if T != Void
class Pointer[T] {...}

my a = Pointer[Int][new]  ;=> works
my b = Pointer[Void][new] ;=> fails: `Void != Void` is false
```

## Typeclasses
So... what happens if you assign a type variable to an alias? You get a typeclass!
```scala
type T {
	on [Str]
}
alias Stringy = T

on [stringy: value (Stringy)] (Str) => return value[Str]
```

Typeclasses can be as complex and as fancy as you want them to be.
They can:
- have any number of type parameters
- be overloaded and refined
- used as category targets
- and allow multiple instances per method/type

On that note, it's important to note that in `Tuple[Stringy, Stringy]`, each instance of `Stringy` is a different type.
If you want them to be the same type, you can bind them to a type variable like `type T of Stringy`.

Also, keep in mind that the right side of the `=` has to be a single type, not a type expression.
```scala
;== Wrong
alias A = B || C

;== Right
type T if T ?= B || T ?= C
alias A = T
```
It may seem a bit verbose, but I promise that it's for the better.

Oh yeah one last thing, you can also specify certain attributes that the type should have:
```scala
type T is native [repr: `int` bits: 8 signed: false]
alias UInt8Like = T

on [thing: value (UInt8Like)] {...}

this[thing: Native.UInt8 5]
this[thing: #"a"]
```
Supported attributes:
- `flags`
- `strong`
- `uncounted`
- `native [...]`

## Dependent types (TBD)
I'm a bit of a noob when it comes to fancy terms like "dependent typing", but this supposedly qualifies:
```scala
type I (Int)
class Thing[I] {...}

my a (Thing[1])   ;=> works
my b (Thing[2])   ;=> works
my c (Thing[3.4]) ;=> fails
```

Also came up with this idea where you can add conditional constraints to the type params. It could be thought of as "dependent refinement types":
```scala
type Bits (Int) if Bits > 0
class Int[Bits] {...}

my a (Bits[1])  ;=> works
my b (Bits[0])  ;=> fails
my c (Bits[-1]) ;=> fails
```

Things to note:
- Dependent type params can only be basic literal types. These include booleans*, integers, decimals, characters, litsyms, and possibly strings.
- For now, these types will not introduce any additional runtime overhead. If the exact type cannot be deduced at compile-time, it will not be valid.

\* I don't actually know how this would work because `T[true]` is technically a method call.

## What can/can't have generic parameters
Can:
- Classes
- Protocols
- Methods (that includes initializers and operator overloads)
- Kinds (for tagged unions)
- Type aliases
- Modules
- Categories

Can't:
- Members/variables

TBD:
- Funcs (anonymous methods)

## What can/can't be used as a generic parameter
Can:
- Classes
- Protocols
- Kinds
- Type aliases
- Modules (as long as it's not used as an actual type)

Can't:
- Categories
- Members/variables
- Methods

TBD:
- Literals (such as integers, decimals, or characters)

## Special cases
Because I don't want to add variadic type arguments, the `Func` type will be a special case in terms of generic parameters. Its
type definition would look something like `Func[Ret, Args...]` since methods can take any number of parameters. I'll
probably explain this more at some other point.

## Future considerations
- Variadic type arguments
- [Labeled type parameters](../concepts/labeled-generics/labeled-generics.md)

## Syntax
```swift
type T1
type T2
; ...
type Tn
<decl>
```

## Languages with related features
- Scala 3: `given` clauses and implicits.
- C++: Concepts and templates in general.
- Nim: Concepts and typeclasses.
- Ada: Syntax and structure of how generic types/methods are declared.