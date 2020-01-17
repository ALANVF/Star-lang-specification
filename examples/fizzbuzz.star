use Core

module Main {
	on [main] {
		for[my i in: [1 to: 100]] {
			case {
				at[i %% 15] {say["FizzBuzz"]}
				at[i %% 3]  {say["Fizz"]}
				at[i %% 5]  {say["Buzz"]}
				default     {say[i]}
			}
		}
	}
}
