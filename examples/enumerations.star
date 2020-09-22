use Core

module Main {
	kind Fruit {
		has apple
		has banana
		has cherry
	}
	
	on [main] {
		my f (Fruit) = Fruit.banana
		Core[say: f] ;=> Fruit.banana
	}
}
