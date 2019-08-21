I haven't been able to come up with a way to use actual generics in Star, but I may have an alternative for them, which is allowing type aliases as properties.

Here's a possible example:
```swift
class Ref {
	alias T
	my value (T)

	init [new: v (T = _)] {
		value = v
	}
}

my r = Ref[new: 5]
```
However, the problem here would be that you can't have a generic type signature (such as `Ref[of: Int]` or something) because it's an instance property. I'll leave it as this for now, but I may change it later.