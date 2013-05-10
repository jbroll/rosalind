#!/usr/bin/env tclkit
#

source isomass.tcl


set data SKADYEK
set data [read [open ~/Downloads/rosalind_prtm.txt]]

proc isomass { data } {
    set sum 0
    foreach p [split $data {}] {
	set sum [expr { $sum + $::ISOMass($p) }]
    }

    set sum
}

puts [format %.2f [isomass $data]]


