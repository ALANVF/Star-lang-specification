; kinds are what most languages call an enum or discriminated union (although really they can be either).
; here's a simple example:
kind Fruit {
	apple
	mango
	banana
}

my fruit = Fruit.mango
Core[say: fruit]       ;=> Fruit.mango
fruit = Fruit.banana
Core[say: fruit]       ;=> Fruit.banana

; regular kinds like this are similar to C-style enums, and they can be compared and also support basic math.
Core[say: Fruit.banana > Fruit.apple] ;=> true
Core[say: Fruit.mango - 1]            ;=> Fruit.apple

; kinds can also be typed, where its members represent a value of said type
kind Sign (Int) {
	negative => -1
	positive => 1
}

Core[say: Sign.negative]           ;=> Sign.negative
Core[say: Sign.negative.value]     ;=> -1
Core[say: 5 * Sign.negative.value] ;=> -5

; you can also specify a kind to act like a C-style enum, which is helpful when binding to C libraries.
kind ObjcBOOL (LLVM.UInt8) is c_enum {
	yes => 1
	no  => 0
}

Core[say: ObjcBOOl.yes]             ;=> ObjcBOOl.yes
Core[say: ObjcBOOl.yes[LLVM.UInt8]] ;=> 1



; now for the fun stuff!
; (some of this stuff is also covered in the pattern matching concept).

; Star also allows kinds to act like discriminated unions.
kind Number {
	[zero]
	[nth: (Int)]
}

Core[say: Number[zero]]   ;=> Number[zero]
Core[say: Number[nth: 1]] ;=> Number[n: 1]

; they can also be matched on.
my num = Number[nth: 2]

match[num] {
	at[Number[zero]] {
		Core[say: "zero"]
	}
	
	at[Number[nth: 1]] {
		Core[say: "one"]
	}
	
	at[Number[nth: my n]] {
		Core[say: n]
	}
} ;=> 2

; I haven't fully decided on the syntax, but this works for now I guess.

; you can also have kinds that have type parameters (whether or not they allow generic specification is TBD).
type T, kind Option[T] {
	[some: (T)]
	[none]
}

my opt1 = Option[some: "thing"] ; Option[Str]
my opt2 = Option[some: 2.3]     ; Option[Dec]

; one issue I've run into is how to determine the type of Option[none] without having to do Option[Type][none].
; obviously this will be irrelevant once I have a type checker, but I don't know what to do until then.
; there's also the case of assigning Option[none] to a variable and never re-assigning it to Option[some:]. what should happen then? should it error?
; an obvious solution would be to have some sort of "throwaway type", but I'd rather leave that as a final resort.
; needless to say, there's still a lot more thinking that needs to happen here.
