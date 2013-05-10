#!/usr/bin/env tclkit
#

source func.tcl

set data {
    ATCCAGCT
    GGGCAACT
    ATGGATCT
    AAGCAACC
    TTGGAACT
    ATGCCATT
    ATGGCACT
}
set data [read [open ~/Downloads/rosalind_cons.txt]]

proc cons { data { matrix {} } } {
    if { $matrix ne {} } {
	upvar 1 $matrix count
    }

    foreach str $data {
	foreach l [split $str {}] x [iota 1 [string len $str]] {
	    incr count($x,$l)
	}
    }

    foreach x [iota 1 [string len $str]] {
	set max 0

	foreach l { A C G T } {
	    catch {
		if { $count($x,$l) > $max } {
		    set max $count($x,$l)
		    set con $l
		}
	    }
	}
	append cons $con
    }

    set cons
}


puts [cons $data matrix]

foreach l { A C G T } {
    puts -nonewline $l:
    foreach x [iota 1 [string length [lindex $data 0]]] {
	try {
	    puts -nonewline " $matrix($x,$l)"
	} on error message {
	    puts -nonewline " 0"
	}
    }
    puts ""
}

