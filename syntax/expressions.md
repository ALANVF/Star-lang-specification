# Expressions

Precedence tree (highest to lowest):
```
a.b, a[b], [a b], a++, a--, a?
++a, --a, -a, ~a, !a
a ** b
a * b, a / b, a // b, a % b
a + b, a - b
a %% b
a & b, a | b, a ^ b, a >> b, a << b
a ?= b, a != b, a > b, a >= b, a < b, a <= b
a && b, a || b, a ^^ b, a !! b
a = b, a += b, a -= b, a *= b, a **= b, a /= b, a //= b, a %= b, a %%= b, a &= b, a |= b, a ^= b, a >>= b, a <<= b, a &&= b, a ||= b, a ^^= b, a !!= b
a => b
a -> [b], a -> [b] = c, a -> b = c, a -> {...}
...a
```

### Literal constructor
Creates an instance of a type using a literal value:
```
Regex "\\d+"
List[Int] #[1, 2, 3]
Native.UInt8 5
Bag[Str] #("a" => 1, "b" => 2)
Promise[Void] {|| return }
```

Literal constructors may use an integer, decimal, character, string, array, hash, tuple, or func literal.

Blocks are currently not allowed as a literal constructor due to it being ambiguous (like `at Type {...}`).

### Property access
Gets a property from a value:
```
obj.property
obj.property = value
```

### Method call
A method call on a value.

#### Single
```
obj[name]
[obj name]
```

#### Multi
```
obj[label: value]
obj[label1: value1 label2: value2]
[obj label: value]
[obj label1: value1 label2: value2]
```

A "multi" method call may appear as an lvalue if the method has the "setter" attribute:
```
type E
class Array[E] {
	on [at: index (Int) set: value (E)] is setter {...}
}

my a = #[1, 2]
a[at: 1] = 3
Core[say: a] ;=> #[1, 3]
```

#### Cast
```
obj[Type]
[obj Type]
```

#### Category
In order to call a method from a category, put the name of the category in the method call:
```
obj[Category name]
obj[Category label: value]
obj[Category Type]
[obj Category name]
[obj Category label: value]
[obj Category Type]
```

This syntax can also be used to call methods that were inherited from a supertype, even if they were overriden.

It's also necessary when mutliple supertypes share the same method in order to remain unambiguous (which also solves the diamond problem).

### Cascade
A cascade is series of calls on a single (value or type), which returns the sender as the final result.
Doing:
```
obj
-> [label: value]
-> property = newValue
-> [label1: value1 label2: value2]
-> [something]
```
is the same as doing:
```
obj[label: value]
obj.property = newValue
obj[label1: value1 label2: value2]
obj[something]
```

You can also nest cascades like this:
```
obj
-> [method1: value1]
--> [method2: value2]
--> [method3: value3]
-> [method4]
```
which is equivalent to the following:
```
obj[method1: value1]
-> [method2: value2]
-> [method3: value3]
obj[method4]
```

Nesting goes as deep as you want it too, so this is entirely valid:
```
obj
-> [method1: value1]
--> [method2: value2]
---> [method3: value3]
----> [method4]
```

As a bonus feature, this single feature makes it impossible to represent Star's grammar using EBNF. 

Cascades may call into a block expression like so:
```
obj
-> {
	this[thing1]
	this[thing3: this[thing4]]
}
-> {
	my thing5 = this.attr
	thing5 = thing6
}
```

Please note that something such as:
```
obj
-> a = a[b]
```
is not valid (for now).

Keeping in mind that cascades are expressions, doing something like `a[b: c->[d: e]->[f: g h: i]]` is perfectly valid,
however the `->` will have higher precedence than when used on a separate line (to make things less visually confusing).

### Prefix operator
- `-a`: negation.
- `~a`: binary not.
- `!a`: logical not.
- `++a`: pre-increment.
- `--a`: pre-decrement.
- `...a`: spread (semantics TBD).

### Postfix operator
- `a?`: logical coercion.
- `a++`: post-increment.
- `a--`: post-decrement.

### Binary operator
- `a ** b`: exponentiation.
- `a * b`: multiply.
- `a / b`: divide.
- `a // b`: floor divide.
- `a % b`: remainder.
- `a + b`: add.
- `a - b`: subtract.
- `a %% b`: divides equally.
	- Can also be thought of as `a % b ?= 0`.
- `a & b`: binary and.
- `a | b`: binary or.
- `a ^ b`: binary exclusive-or.
- `a >> b`: binary right-shift.
- `a << b`: binary left-shift.
- `a ?= b`: equality.
- `a != b`: inequality.
- `a > b`: greater.
- `a >= b`: greater or equal.
- `a < b`: less.
- `a <= b`: less or equal.
- `a && b`: logical and.
- `a || b`: logical or.
- `a ^^ b`: logical exclusive-or.
- `a !! b`: logical nor.
- `a = b`: assignment.
- `a <op>= b`: compound assignment (same as `a = a <op> b`).

Notes:
- `=` supports destructuring assignment.
- logical operators may precede a chain of expressions when used inside `(...)`:
```
if (
	|| a
	|| b
	|| ...
) {...}
```

### Future considerations
- `a of B`: type assertion.
- `a ~~ b`: smart-match.
- `a \& b`: and-junction.
- `a \| b`: or-junction.
- `a \^ b`: one-junction.
- `a \! b`: none-junction.
- Remove bitwise operators (and possibly replace them with something else).
- `a = [b]`: `a = a[b]`.
	- Currently ambiguous due to category methods.
- Some operator for testing reference equality/inequality

### Notes
- There is currently no way to call an operator overload with a category (I'm not sure how I overlooked that one).