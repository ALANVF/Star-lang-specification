### Value kinds

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


### Base type

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


### Tagged kinds

Now for the fun stuff!
(some of this stuff is also covered in the pattern matching concept).

Star also allows kinds to act like tagged unions.
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


### Members

Kinds may have static/instance members:
```swift
kind Token {
	my position (Int)

	has [this]
	has [int: (Int)]
	has [assign: (Expr) to: (Expr)]
}

my thisToken = Token[this]
-> position = 1 ;-- We can't pass `position:` as a parameter because `this` takes no args

my intToken = Token[int: 123 position: 8]

my assignToken = Token[assign: thisToken to: intToken position: 6]

Core[say: assignToken.position] ;=> 6
```


It should be worth noting that value kinds (as opposed to tagged kinds) currently aren't allowed to have instance members.
This restriction may be lifted in the future.


### Inheritance

Unlike most languages, Star allows kinds to inherit from types.

In particular, kinds may inherit from other kinds, which is not allowed in other languages for whatever reason.
When this happens, the hierarchy becomes flipped, where the supertype is always compatable with the subtype, but the opposite is not always true.
```swift
kind Parent {
	has a
	has b
}

kind Child of Parent {
	has c
}

my value1 = Child.c
my value2 = Child.b

Core
-> [say: value1[Parent]] ;=> error!
-> [say: value2[Parent]] ;=> Parent.b
```

#### Why?

Because I think that by removing the distinction between variants and classes, we can discover new and better ways to represent and structure data.

Why *shouldn't* variants be allowed to have methods?

Why *shouldn't* variants be allowed to have unified properties?

Why *shouldn't* variants be allowed to implement interfaces and extend classes?

Why *shouldn't* variants be allowed to inherit other variants??

The answer to all of these questions is that there **is no good reason**, so these restrictions should be lifted in order to give the programmer more power and make the language more complete.


TODO:
- flag kinds