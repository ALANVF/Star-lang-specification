use Core

module Main {
	kind Fruit {
		Apple
		Banana
		Cherry
	}
	
	on [main] {
		my f (Fruit) = Fruit.Banana
		say[f] ;=> Fruit.Banana
	}
}
