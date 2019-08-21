use Core

macro [
	`if2`
	[cond1 (Star.AST.Expr), cond2 (Star.AST.Expr)]
	both (Star.AST.Block)
	`else1`
	only1 (Star.AST.Block)
	`else2`
	only2 (Star.AST.Block)
	`else`
	neither (Star.AST.Block)
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
			say["both"]
		} else1 {
			say["only 1st"]
		} else2 {
			say["only 2nd"]
		} else {
			say["neither"]
		}
		
		;=> "only 2nd"
	}
}