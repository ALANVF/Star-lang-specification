https://en.wikipedia.org/wiki/Loop_unswitching seems very useful as a loop optimization (and a general option), since it's common for naive programmers to put a constant conditional that's very slow/resource-intensive inside a loop (like a string comparison).

Maybe something like this?
```star
for ... {
	a
	if b uplevel: 1 {
		c
	}
}
```

==>

```star
if b {
	for ... {
		a
		c
	}
} else {
	for ... {
		a
	}
}
```

Although this does mean that `b` would have to be a pure expression, I'm sure it could still be helpful as a feature.

Other thoughts:
- Once labeled loops are added, `uplevel:` should support them as well.

Other links:
- https://www.cs.cornell.edu/courses/cs6120/2019fa/blog/loop-unswitching/


----------------------------------

Cascade blocks seem kinda incomplete.

Should they be allowed to return into the outer scope, or are they forced to return void?

Maybe a `do {...}` cascade could be added, which does just that? If so, should we just have "cascade statements", also including other statements
like for loops and such? If so (again), what should the scoping rules be? Should they be the same as the outer expression, or use the scope of `this`/`This`?

Cascades in general also seem incomplete.

In the context of a cascade (that's not a block), how does one disambiguate/assume the difference between `this.x` and `x`?

Should static cascades (cascades on a type) be allowed to have types as a cascade branch?
I'm thinking of something like
```star
Outer
-> Inner
--> ...
```
to represent
```star
Outer.Inner
-> ...
```

----------------------------------

Java-like enums would be nice. Maybe they could even replace the default "value kind" syntax
```star
kind Error {
	my description (Str) is getter
	my color (Color) is getter
	
	has note           => This[description: "note" color: Color.green]
	has warning        => This[description: "warning" color: Color.yellow]
	has error          => This[description: "error" color: Color.red]
	has internal_error => This[description: "internal error" color: Color.magenta]
}
```

Would these be inheritable? Probably not very much...

----------------------------------

There needs to be a way to parameterize `This` and treat it like an HKT, relative to its base type.

----------------------------------

A possible alternative syntax for methods:
```star
class A of B, C {
	on This[staticMethod] {...}
	on this[instanceMethod] {...}
	
	on this[ambiguousMethod] {...}
	on this[B ambiguousMethod] {...}
	on this[C ambiguousMethod] {...}
}
```

Not sure how this syntax would work for operator overloads or initializers.

----------------------------------

For-in loops and iterators are currently magical by accident:
```star
class A of Iterable[Int] {
	on [Iterator[Int]] {
		my i = 0
		return LazyIterator[Int] {||
			if i ?= 10 {
				return Maybe[none]
			} else {
				return Maybe[the: i++]
			}
		}
	}
}
```

A possible alternative:
```star
class A {
	for (Int) {
		my i = 0
		while true {
			if i ?= 10 {
				return
			} else {
				return i++
			}
		}
	}
}
```
or a cleaner version:
```star
class A {
	for (Int) {
		for my i from: 0 upto: 10 {
			return i
		}
		
		return
	}
}
```

Obviously this has its downsides, as it makes the behavior of `return` inconsistent.
However, I wouldn't want a keyword that's *only* used for yielding values.

Here's one last idea I had that technically fixes that:
```star
class A {
	for my result (Int) in: this {
		my i = 0
		while true {
			if i ?= 10 {
				break 2
			} else {
				result = i++
			}
		}
	}
}
```
which is better written as:
```star
class A {
	for my result (Int) in: this {
		for my i from: 0 upto: 10 {
			result = i
		}
		
		break
	}
}
```

Still a bit weird, but at least it's consistent(-ish?).

----------------------------------

Patch modules: modules that modify part of an existing module rather than being a new one.
Kinda like a patch file for actual code I guess.

