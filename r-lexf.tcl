#!/usr/bin/env tclkit
#

source func.tcl

source rosie.tcl

set data {
    T A G C
    2
}
#set data [read [open ~/Downloads/rosalind_lexf.txt]]

proc prod { d1 d2 } {
    foreach x $d1 {
	foreach y $d2 {
	    lappend reply $x$y
    } }

    set reply
}


puts [join [combi {*}[split [string trim $data] \n]] \n]

