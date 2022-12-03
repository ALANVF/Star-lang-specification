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

----------------------------------

List comprehensions:
```star
my array = #[1, 2, 3]
my array' = #[for my value in: array => return value + 1] ;=> #[2, 3, 4]
```

Could also be extended to dicts, although I'm not a fan of special-casing the return syntax
for it:
```star
my dict = #("a" => 1, "b" => 2, "c" => 3)
my dict' = #(for my k, my v in: dict => return k => v + 1)
```
Maybe `return #{k, v + 1}` could be used instead?

Also a note, you could have multiple comprehensions per literal
```star
my ranges = #[
	for my i from: 1 to: 5 => return i
	10
	12
	for my i from: 20 downto: 15 => return i
]
;=> #[1, 2, 3, 4, 5, 10, 12, 20, 19, 18, 17, 16, 15]
```

Maybe if-statements and other control flow could be allowed?
```star
#[
	if foo => return bar
	while cond {
		return thing[stuff]
	}
]
```
Honestly, array and dict literals could be treated similarly to block expressions (although that
raises the issue of implicit returns for non-statement entries)

If the default rules for `return` are scrapped entirely (for some reason), maybe it would also be
possible to have multiple returns per statement
```star
#[
	for my i from: 1 to: 5 {
		return i
		return i * 2
	}
]
;=> #[1, 2, 2, 4, 3, 6, 4, 8, 5, 10]
```

In either case, implicit returns for these comprehensions are a no-no.

These should also ideally work with user-defined literal constructors
```star
my set = Set #[for my i from: 1 to: 5 => return i]
;=> Set[Int] #[1, 2, 3, 4, 5]
```

----------------------------------

Combined loop structure:
```star
for my value in: values from: 1 upto: 10 by: 2 {
	...
}
```

The issue is that I'm not sure how this would be able to be user-defined,
unless I were to use my proposed solution that fixes magical iteration semantics
```star
type T
class Array[T] {
	for my result (T) in: this from: (Int) upto: (Int) by: (Int) {
		for my i :from :upto :by {
			result = buffer[at: i]
		}
		
		break
	}
}
```

Of course, this would be extremely tedious because of all the different looping variants
(unless it was defined to only work on integers, which I'd rather avoid)

----------------------------------

Looping over multiple things at the same time:
```star
my array1 = #[1, 2, 3]
my array2 = #[4, 5, 6]
for my value1, my value2 in: array1, array2 {
	Core[say: value1 + value2]
}
;=> 5
;=> 7
;=> 9
```

No clue how this would be implemented, but at the very least it would throw an error if
they don't yield the same number of values

----------------------------------

Apparently this is ambiguous:
```star
Foo[bar: a baz: b] = value
```

This could be either be:
1) destructuring `value` (either a memberwise or variant pattern)
2) calling a static setter method on `Foo`

The latter will be preferred for now, but how was this even overlooked?
What should be used instead??

----------------------------------

Assertions could be neat:
```star
assert 0 <= index < array.length
return array[at: index]
```

They could be disabled based on whether or not it's a debug or a production build.

My original idea was to also allow custom exceptions to be thrown
```star
assert 0 <= index < array.length throw IndexError[at: index]
return array[at: index]
```
but this might encourage users to use assertions for production code.

----------------------------------

Inferred kind values/tags:
```star
my foo (MyValueKind) = $someTag
my bar (MyTaggedKind) = $[someTag: value]
my baz (MyMultiKind) = $flag1 | $flag2
```

I see this mainly being useful for kinds that are used for options/flags and in pattern matching:
```star
my foo = Regex[new: "\\s+" flags: Regex.Flags.global | Regex.Flags.multiline]
my bar = Regex[new: "\\s+" flags: $global | $multiline]

match maybeValue {
	at $[the: my value] { ... }
	at $[none] { ... }
}
```

Star currently requires all constructed values (kinds and classes) to be fully qualified with a type, which helps to make code self-documenting. This may discourage that style of code, which will eventually fall back onto the user and make it more difficult for them to read and work on existing code.

Unfortunately, this will also make typechecking more difficult as it will require the typechecker to be fully bidirectional (which already needs to happen anyways because of closures / anon args).