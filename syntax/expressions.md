# Expressions

Precedence tree (highest to lowest):
```
a.b, a[b], [a b]
++a, --a, +a, -a, !a, ~a, a++, a--, a?
a ** b
a * b, a / b, a // b, a % b
a + b, a - b
a %% b
a & b, a | b, a ^ b, a >> b, a << b, a >>> b
a ?= b, a != b, a > b, a >= b, a < b, a <= b
a && b, a || b, a ^^ b
a = b, a += b, a -= b, a *= b, a **= b, a /= b, a //= b, a %= b, a %%= b, a &= b, a |= b, a ^= b, a >>= b, a <<= b, a >>>= b, a &&= b, a ||= b, a ^^= b
a => b
a -> [b], a -> b = c
```

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

#### Context call
A context call implicitly sends the message to `this`. Might be removed at some point in the future.
```
[name]
[label: value]
[label1: value1 label2: value2]
[Type]
```

### Cascade
A cascade is series of calls on a single value, which returns the sender as the final result. Doing:
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

Keeping in mind that cascades are expressions, doing something like `a[b: c->[d: e]->[f: g h: i]]` is perfectly valid.

### Prefix operation
- `+a`: you should know what this does.
- `-a`: negation.
- `~a`: binary not.
- `!a`: logical not.
- `++a`: pre-increment.
- `--a`: pre-decrement.

### Postfix operation
- `a?`: haven't fully decided, but it'll either be definedness checking or logical coercion.
- `a++`: post-increment.
- `a--`: post-decrement.

### Binary operation
- `a ** b`: exponentiation.
- `a * b`: multiply.
- `a / b`: divide.
- `a // b`: floor divide.
- `a % b`: remainder.
- `a + b`: add.
- `a - b`: subtract.
- `a %% b`: divides equally.
- `a & b`: binary and.
- `a | b`: binary or.
- `a ^ b`: binary exclusive-or.
- `a >> b`: binary right-shift.
- `a << b`: binary left-shift.
- `a >>> b`: binary unsigned right-shift.
- `a ?= b`: equality.
- `a != b`: inequality.
- `a > b`: greater.
- `a >= b`: greater or equal.
- `a < b`: less.
- `a <= b`: less or equal.
- `a && b`: logical and.
- `a || b`: logical or.
- `a ^^ b`: logical exclusive-or.
- `a = b`: assignment.
- `a <op>= b`: compound assignment (same as `a = a <op> b`).

### Future considerations
- `a isa B`: type assertion.
- `a ~~ b`: smart-match.
- `a !! b`: logical nor.
- `a \& b`: and-junction.
- `a \| b`: or-junction.
- `a \^ b`: one-junction.
- `a \! b`: none-junction.