use Core

module Main {
    on [main] {
        if[1 ?= 1] {
            say[true]
        }
        
        if[1 ?= 2] {
            say[true]
        } else {
            say false
        }
        
        if[1 ?= 2] {
            say["1 equals 2"]
        } orif[1 != 1] {
            say["1 doesn't equal 1"]
        } else {
            say["ya both wrong"]
        }
        
        ; there is also a shorthand for an if/else statement
        [[prompt][Int] >= 0 yes: "positive"
                             no: "negative"]
        
        ; as a replacement for a long if/orif/else statement
        case {
            at[false && true] {say[1]}
            at[false ^^ true] {say[2]}
            at[false || true] {say[3]}
            default           {say[4]}
        } ;=> 3
        
        ;[conditional operators:
            `&&` = and
            `||` = or
            `^^` = nor/xor
            `!`  = not
            `?`  = has a value?
        ]
    }
}