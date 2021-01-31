Kinds are what most languages call an enum or discriminated union (although really they can be either).
Here's a simple example:
```swift
kind Fruit {
	has apple
	has mango
	has banana
}

my fruit = Fruit.mango
Core[say: fruit]       ;=> Fruit.mango
fruit = Fruit.banana
Core[say: fruit]       ;=> Fruit.banana
```

Regular kinds like this are similar to C-style enums, and they can be compared and also support basic math.
```swift
Core[say: Fruit.banana > Fruit.apple] ;=> true
Core[say: Fruit.mango[previous]]      ;=> Fruit.apple
```

Kinds can also be typed, where its members represent a value of the specified type.
```swift
kind Sign (Int) {
	has negative => -1
	has positive => 1
}

Core[say: Sign.negative]           ;=> Sign.negative
Core[say: Sign.negative.value]     ;=> -1
Core[say: 5 * Sign.negative.value] ;=> -5
```


Now for the fun stuff!
(some of this stuff is also covered in the pattern matching concept).

Star also allows kinds to act like discriminated unions.
```swift
kind Number {
	has [zero]
	has [nth: (Int)]
}

Core[say: Number[zero]]   ;=> Number[zero]
Core[say: Number[nth: 1]] ;=> Number[nth: 1]
```

They can also be matched on.
```swift
my num = Number[nth: 2]

match num {
	at Number[zero] => Core[say: "zero"]
	at Number[nth: 1] => Core[say: "one"]
	at Number[nth: my n] => Core[say: n]
} ;=> 2
```

You can also have kinds that have type parameters.
```swift
type T
kind Option[T] {
	has [some: (T)]
	has [none]
}

my opt1 = Option[some: "thing"] ; Option[Str]
my opt2 = Option[some: 2.3]     ; Option[Dec]
```

TODO:
- Case initializers
- Kind inheritance
- Kind members