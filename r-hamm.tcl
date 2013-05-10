#!/usr/bin/env tclkit
#


set data { 
    GAGCCTACTAACGGGAT
    CATCGTAATGACGGCCT
}
set data [read [open ~/Downloads/rosalind_hamm.txt]]

proc hamm { d1 d2 } {
    foreach d1 [split $d1 {}] d2 [split $d2 {}] {
	incr hamm [expr { $d1 != $d2 }]
    }

    set hamm
}

puts [hamm {*}$data]


