use Core

module Main {
	kind Fruit {
		apple
		banana
		cherry
	}
	
	on [main] {
		my f (Fruit) = Fruit.banana
		Core[say: f] ;=> Fruit.banana
	}
}
