#!/usr/bin/env tclkit
#

source func.tcl

set data {5 3}
set data [read [open ~/Downloads/rosalind_fib.txt]]

# Memo the natural recursize solution
#
proc fibx { n x } {
    if { $n <= 2 } { return 1 }

    return [expr [fibx [expr $n-1] $x] + [fibx [expr $n-2] $x]*$x]
}
memo fibx

lassign $data n x 


# Dynamic programming solution
#
proc fibd { n x } {
    set a 1
    set b 0

    foreach i [iota 0 $n-1] {
	lassign [list [expr $a+$b*$x] $a] a b
    }

    return $b
}

puts [fibd $n $x]
puts [fibx $n $x]


