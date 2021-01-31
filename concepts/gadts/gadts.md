Purely conceptual for now

```star
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