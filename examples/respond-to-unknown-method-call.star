use Core

class Thing {
	macro [unknownMessage: msg (AST.Message)] {
		; atm, the only way I could imagine this working is through macros since Star is statically typed. not sure about the details yet
		
		"not sure what \(@(msg[Str])) is"
	}
}

module Main {
	on [main] {
		my thing = Thing[new]
		
		Core[say: thing[isThisAnInvalidMessage: true youSure: "yes"]] ;=> "not sure what Thing[isThisAnInvalidMessage: true, youSure: "yes"] is"
	}
}