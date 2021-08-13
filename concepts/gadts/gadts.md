Purely conceptual for now

```scala
type T
kind Expr[T] {
	has [plus: a (Expr[Num]), b (Expr[Num])] (Expr[Num])
	has [times: a (Expr[Num]), b (Expr[Num])] (Expr[Num])
	has [power: a (Expr[Num]), b (Expr[Num])] (Expr[Num])

	has [greater: a (Expr[Num]), b (Expr[Num])] (Expr[Bool])
	has [not: a (Expr[Bool])] (Expr[Bool])
	has [or: a (Expr[Bool]), b (Expr[Bool])] (Expr[Bool])
	has [and: a (Expr[Bool]), b (Expr[Bool])] (Expr[Bool])

	has [const: v (T)] (Expr[T])
	
	type U
	has [equals: a (Expr[U]), b (Expr[U])] (Expr[Bool])
}
```

It's worth noting that GADTs are already kinda possible via type specialization or inheritance
```scala
type T
kind Expr[T] {
	has [const: v (T)]
}

kind Expr[Num] {
	has [plus: a (Expr[Num]), b (Expr[Num])]
	has [times: a (Expr[Num]), b (Expr[Num])]
	has [power: a (Expr[Num]), b (Expr[Num])]
}

kind Expr[Bool] {
	has [greater: a (Expr[Num]), b (Expr[Num])]
	has [not: a (Expr[Bool])]
	has [or: a (Expr[Bool]), b (Expr[Bool])]
	has [and: a (Expr[Bool]), b (Expr[Bool])]

	;-- This technically isn't allowed, but you get the idea
	type U
	has [equals: a (Expr[U]), b (Expr[U])]
}