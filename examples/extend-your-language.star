use Core

macro [
	`if2`
	[cond1 (AST.Expr), cond2 (AST.Expr)]
	both (AST.Block)
	`else1`
	only1 (AST.Block)
	`else2`
	only2 (AST.Block)
	`else`
	neither (AST.Block)
] is pattern {
	match[@cond1, @cond2] {
		at[true, true]  @both
		at[true, false] @only1
		at[false, true] @only2
		default         @neither
	}
}

module Main {
	on [main] {
		if2[false, true] {
			Core[say: "both"]
		} else1 {
			Core[say: "only 1st"]
		} else2 {
			Core[say: "only 2nd"]
		} else {
			Core[say: "neither"]
		}
		
		;=> "only 2nd"
	}
}