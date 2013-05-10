#!/usr/bin/env tclkit
#

source rosie.tcl
source func.tcl


set data {
    2 10
    0.32 0.42 0.81
}
set data [read [open ~/Downloads/rosalind_eval.txt]]

set data [lassign $data m n]


#puts "$m $n"

foreach gc $data {
    #puts -nonewline "$gc "

    set p [expr $gc/2]
    set P [expr (1-$gc)/2]

    set p [expr $p*$p + $p*$p + $P*$P + $P*$P]

    set p [expr { pow($p, $m) * ($n-($m-1)) }]
    puts -nonewline [format "%.6f " $p]
}
puts ""





