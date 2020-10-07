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
Similarly to C++, Star uses "templates" for generic structures. In the above example, `T` becomes a generic type for the class `Box` (and then disappears afterwards),
which takes `T` as a type argument. One thing I might consider in the future is allowing the type arguments to be inferred for generic types. Until then, you could
do something like this to emulate it:

```swift
module Box {
	type T
	on [value: (T)] {
		return Box[T][value: value]
	}
}

type T
class Box[T] {
	my value (T)
}

my box1 = Box[value: 1]
my box2 = Box[value: 2.3]
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

```swift
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

## Generic constraints
Kinda self-explainitory:
```swift
; ...
type T of Real
on [doThing: val (T)] {Core[say: val]}
; ...
[doThing: 1]   ;=> works
[doThing: 2.3] ;=> works
[doThing: "a"] ;=> fails: type `Str` does not conform to the `Real` protocol
```

Refinement types also exist:
```swift
type T if T != Void
class Pointer[T] {...}

my a = Pointer[Int][new]  ;=> works
my b = Pointer[Void][new] ;=> fails: `Void != Void` is false
```

## Dependent types (TBD)
I'm a bit of a noob when it comes to fancy terms like "dependent typing", but this supposedly qualifies:
```swift
type I (Int)
class Thing[I] {...}

my a (Thing[1])   ;=> works
my b (Thing[2])   ;=> works
my c (Thing[3.4]) ;=> fails
```

Also came up with this idea where you can add conditional constraints to the type params. It could be thought of as "dependent refinement types":
```swift
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

Can't:
- Categories
- Members/variables

TBD:
- Modules
- Macros
- Funcs (anonymous methods)

## What can/can't be used as a generic parameter
Can:
- Classes
- Protocols
- Kinds
- Type aliases
- Literals (such as integers, decimals, or characters)

Can't:
- Categories
- Modules
- Members/variables
- Methods
- Macros

## Special cases
Because I don't want to add variadic type arguments, the `Func` type will be a special case in terms of generic parameters. Its
type definition would look something like `Func[Ret, Args...]` since methods can take any number of parameters. I'll
probably explain this more at some other point.

## Future considerations
- Variadic type arguments
- Labeled type parameters

## Syntax
```swift
type T1
type T2
; ...
type Tn
<decl>
```