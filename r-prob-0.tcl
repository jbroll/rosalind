#!/usr/bin/env tclkit
#

source rosie.tcl

set data { 0.23 0.31 0.75 }
set data [read [open ~/Downloads/rosalind_prob.txt]]

foreach gc $data {
    set p [expr $gc/2]
    set P [expr (1-$gc)/2]

    set x [expr $p*$p + $p*$p + $P*$P + $P*$P]

    puts -nonewline [format "%.6f " $x]
}

puts {}

