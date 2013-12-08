# http://en.wikipedia.org/wiki/Levenshtein_distance
# 
proc leven { s t } {
    # degenerate cases
    if { $s eq $t } { return 0 }
    if { ![string length $s] } { return [string length $t] }
    if { ![string length $t] } { return [string length $s] }
 
    set v0 {}
    for { set i 0 } { $i <= [string length $t] } { incr i } { lset v0 $i $i }   ; # the distance is just the number of characters to delete from t
										 # for an empty s.
    set v1 [lrepeat [expr { [string length $t]+1 }] 0] 	      			; # zero current row.

    for { set i 0 } { $i < [string length $s] } { incr i } { 
        # calculate v1 (current row distances) from the previous row v0
 
        lset v1 0 [expr { $i + 1 }] 			      ; # first element of v1 is A[i+1][0]
        							#   edit distance is delete (i+1) chars from s to match empty t
 
	for { set j 0 } { $j < [string length $t] } { incr j } { 		# use formula to fill in the rest of the row

	    set cost [expr { ([string index $s $i] eq [string index $t $j]) ? 0 : 1 }]

	    lset v1 $j+1 [expr { min([lindex $v1 $j] + 1, [lindex $v0 $j+1] + 1, [lindex $v0 $j] + $cost) }]
	}

	set v0 $v1 					     ; # copy v1 (current row) to v0 (previous row) for next iteration
    }
 
    return [lindex $v1 end]
}
