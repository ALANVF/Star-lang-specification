# Categories

Categories are kinda like nominal type extensions. You might find them similar to Rust's traits, Objective-C's categories, or Dart's static extensions. The cool thing is that you'd be right either way, because categories are all 3 those things + some extra stuff. If you have no clue what I'm talking about, you can think of them as fancy utility classes/modules/functors/take your pick.

A quick example:
```scala
category Str for Int {
	on [length] (Int) {
		if this ?= 0 {
			return 1
		} else {
			return [this[abs] + 1 log: 10][ceiling][Int]
		}
	}
}

123[Str length] ;=> 3
```

But... `Str` is already a type, right? Well, categories are actually identified by a pre-existing type rather than being a type themself.
This includes modules, classes, prototcols (which can add method requirements for subtypes within the category), kinds (you cannot add new cases),
aliases, and even typeclasses. As an added bonus, categories can be generic, meaning that type variables are also permitted.

Because categories are identified by types, they also follow the subtyping rules of the type (the target type also behaves this way).
```scala
class A {}
class A of B {}

category A for Int {
	on [method1] (Str) => return "A's method1 for \(this)"
	on [method2] (Str) => return "A's method2 for \(this)"
}

category B for Int {
	on [method1] (Str) => return "B's method1 for \(this + 1)"
}

5
-> [A method1] ;=> "A's method1 for 5"
-> [A method2] ;=> "A's method2 for 5"
-> [B method1] ;=> "B's method1 for 6"
-> [B method2] ;=> "A's method2 for 5"
```

When combined with generics, this could be very powerful...
```scala
type T of A
on [thing: value (T), int (Int)] {
	Core[say: int[T method1]]
}

This[thing: A[new], 5] ;=> "A's method1 for 5"
This[thing: B[new], 5] ;=> "B's method2 for 6"
```

I'm not entirely sure what else to compare this to, or even what to call it. "Associated vtables"? "Dual-dispatch"?? "Funny rust traits"???

## Other notes

A generic type can be its own category:
```scala
type T
type U
category Array[U] for Array[T] {
	on [thing] {...}
}

#[1, 2, 3][Array[Str] thing]
```
This also works every other way you'd expect. Have fun.

<br>

Categories can be refined and overloaded, as well as their targets.

<br>

Categories can be used in structural generics:
```scala
type T {
	category Str {
		...
	}
}
alias DoesTheStrThing = T
```
Please don't use type variables as a category in a constraint, I don't know how to typecheck that.

<br>

Categories are not types themselves, so please don't accidently do `type T of MyCategory` as a type constraint.

<br>

You can use categories to explicitly pass type parameters to a method. This is basically how `IO` types work:
```scala
if Core.stdin[IO[Bool] prompt: "Is Star cool? "] {
	my rating = Core.stdin[IO[Int]
		prompt: "How would you rate it? "
		inRange: [1 to: 10]
	]
}
```

<br>

...more here later?