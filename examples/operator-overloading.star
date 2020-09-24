use Core

class Vector {
    my x (Int)
    my y (Int)
    
    operator `+` [v (Vector)] (Vector) {
        return Vector[x: this.x + v.x
                      y: this.y + v.y]
    }
    
    operator `-` [v (Vector)] (Vector) {
        return Vector[x: this.x - v.x
                      y: this.y - v.y]
    }
    
    operator `?=` [v (Vector)] (Bool) {
        return this.x ?= v.x && this.y ?= v.y
    }
}

module Main {
    on [main] {
        my v1 = Vector[x: 5 y: 10]
        my v2 = Vector[x: 1 y: 2]
        
        Core[say: v1 + v2]                 ;=> Vector[x: 6 y: 12]
        Core[say: v1 - v2]                 ;=> Vector[x: 4 y: 8]
        Core[say: v2 ?= Vector[x: 1 y: 2]] ;=> true
    }
}
