
proc lintersect {a b} {
     foreach e $a {
 	set x($e) {}
     }
     set result {}
     foreach e $b {
 	if {[info exists x($e)]} {
 	    lappend result $e
 	}
     }
     return $result
 }

 proc lunion {a b} {
     foreach e $a {
 	set x($e) {}
     }
     foreach e $b {
 	if {![info exists x($e)]} {
 	    lappend a $e
 	}
     }
     return $a
 }

 proc ldifference {a b} {
     set result {}
     foreach e $a {
 	if {$e ni $b} {lappend result $e}
     }
     return $result
 }
