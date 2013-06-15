#!/usr/bin/env tclkit
#
source func.tcl

#           o
#           O
#           O o
#           o O
#	    O O o
#	    O o O     o
#	    o O O   o O
#	    O O o o O O o
#	    O o o O O O o o O

set data {6 3}
set data {60 3}
set data [read [open ~/Downloads/rosalind_fibd.txt]]

# Memo the natural recursize solution
#
proc fibr { n x d } {

    if { $n <   0 } { return 0 }
    if { $n <=  2 } { return 1 }

    #puts "fibr dead [fibr [expr $n-$d-1] $x $d]"

     return [expr [fibr [expr $n-1] $x $d] + [fibr [expr $n-2] $x $d]*$x - [fibr [expr $n-$d-1] $x $d]]
}
memo fibr

set x 1
lassign $data n d 

# Dynamic programming solution
#
proc fibd { n x d } {
    set a 1
    set b 0
    set die 0

    set cue [lrepeat [expr $d-1] 0]
    lappend cue 1

    foreach i [iota 0 $n-1] {
	set cue [list {*}[lassign $cue die] $a]

	lassign [list [expr $a+$b*$x-$die] $a] a b
    }

    return $b
}

#puts "0 0 [fibr 0 1 3] [fibd 0 1 3]"
#puts "1 1 [fibr 1 1 3] [fibd 1 1 3]"
#puts "2 1 [fibr 2 1 3] [fibd 2 1 3]"
#puts "3 2 [fibr 3 1 3] [fibd 3 1 3]"
#puts "4 2 [fibr 4 1 3] [fibd 4 1 3]"
#puts "5 3 [fibr 5 1 3] [fibd 5 1 3]"
#puts "6 4 [fibr 6 1 3] [fibd 6 1 3]"
#puts "7   [fibr 7 1 3] [fibd 7 1 3]"
#puts "8   [fibr 8 1 3] [fibd 8 1 3]"
#puts "9   [fibr 9 1 3] [fibd 9 1 3]"

puts [fibr $n $x $d]
puts [fibd $n $x $d]


