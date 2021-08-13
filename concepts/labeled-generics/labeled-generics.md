(For reference, labeled type arguments would be uppercase like type names)


So this could go one of two ways.


# Option 1

The first option is to just use the labels as labels, and nothing else.

```scala
type T
class Array[Of: T] {
	...
	on [Iterator[T]] { ... }
	...
}
```

The issue with this is that you can't have no-arg labels like you can with
normal methods (like `a[b]`), as `A[B]` syntax would mean something different.


# Option 2

The second option fixes the issue with the first option.

```scala
type T
class Array[Of: T] {
	...
	on [Iterator[Of: T]] { ... }
	...
}
```

Basically, the idea here is that generic types look and act very similar to regular methods,
where `a[b]` and `A[B]` have the same meaning, as well as `a[b: c]` and `A[B: C]`. Although
this fixes the ambiguity problem from earlier, there are still some issues.


To start, there's a very low chance that people will want to use labels for everything
that's generic. Although the point here is to provide new features while keeping them
unambiguous / consistent with the rest of the language, user-friendliness is also an
important factor here.

Another thing worth noting is that the type-cast syntax (`a[B]`) would clash a bit with the
no-arg generic type syntax (`A[B]`), which means that it's ambiguous. This is an unexpected
road-block, but I definitely want to investigate this idea more in the future. It'd be pretty
cool if type constraints could look (and act) just like regular method parameters:
```scala
protocol Sequential[Index: I (Comparable), Element: E (_)] {
	...
}
```