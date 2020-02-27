use Core

module Main {
	on [main] {
		for[my i in: [1 to: 100]] {
			case {
				at[i %% 15] {Core[say: "FizzBuzz"]}
				at[i %% 3]  {Core[say: "Fizz"]}
				at[i %% 5]  {Core[say: "Buzz"]}
				default     {Core[say: i]}
			}
		}
	}
}
