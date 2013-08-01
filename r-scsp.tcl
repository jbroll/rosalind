#!/usr/bin/env tclkit
#

source func.tcl
source rosie.tcl


set data {
    ATCTGAT
    TGCATA
}
#set data [read [open ~/Downloads/rosalind_scsp.txt]]

proc scs { A B } {
    set C [lcs $A $B]
    set i 0
    set j 0
    set k 0

    set lenC [string length $C]

    while { $k < $lenC } {
	set cA [string index $A $i]
	set cB [string index $B $j]
	set cC [string index $C $k]

	if { $cA eq $cC } {
	    if { $cB eq $cC } {
		append scs $cC
		incr i
		incr k
	    } else {
		append scs $cB
	    }
	    incr j
	} else {
	    append scs $cA
	    incr i
	}
    }

    append scs [string range $A $i end] [string range $B $j end]
    return $scs
}

lassign $data A B 

puts [scs $A $B]
