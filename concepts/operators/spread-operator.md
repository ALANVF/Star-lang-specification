# The "spread operator"

Unfortunately, making a good user-definable spread operator is hard, especially if you don't want any abstractions used on top of it (like iterators or streams or something like that). But I think I've now come up with a pretty good design for them:

```star
type T
class Array[T] {
	; ...

	operator `...` [value (T)] (This) {
		this[add: value]
		return this
	}

	type I of Iterable[T]
	operator `...` [values (I)] (This) {
		this[addAll: values]
		return this
	}
}

my a = #[1, 2, 3]
my b = #[4, 5, ...a, 6, 7]

;-- Essentially translates to:

my a = #[1, 2, 3]
my b = ((#[4, 5] ... a) ... 6) ... 7
```

This would only be called during the construction of a literal, or if a type uses a literal constructor. Because this operator returns a value (of the type `This` (usually the caller)), it's possible to implement this for immutable types such as cons lists:

```star
type T
kind List[T] {
	has [nil]
	has [head: (T) tail: (This)]

	; ...

	on [add: value (T)] (This) {
		match this at This[head: my head tail: my tail] {
			return This[:head tail: tail[add: value]]
		} else {
			return This[head: value tail: This[nil]]
		}
	}

	on [addAll: values (This)] (This) {
		match this at This[head: my head tail: my tail] {
			return This[:head tail: tail[add: value]]
		} else {
			return tail
		}
	}

	operator `...` [value (T)] (This) => return this[add: value]

	operator `...` [values (This)] (This) => return this[addAll: values]
}

my a = List #[1, 2, 3]
my b = List #[4, 5, ...a, 6, 7]

;-- Essentially translates to:

my a = List #[1, 2, 3]
my b = ((List #[4, 5] ... a) ... 6) ... 7
```

You could also implement this operator for tuples (I am not providing an example for this bc it would be very long).

I would also like to have this operator for associative types, but I'm not sure how I'd do that yet. Maybe using tuple pairs? (it would incur a slight penalty due to the allocation/access of the tuple(s)).