#!/usr/bin/env tclkit
#


set data CAGTAAGCAGGGACTG
set data [string trim [read [open ~/Downloads/rosalind_kmp.txt]]]



proc failure-array { data } {		# From pseudo code on Wikipedia
    set len [string length $data]
    set cnd 0
    set pos 1

    set T [lrepeat $len 0]

    while { $pos < $len } {
    	if { [string index $data $pos] eq [string index $data $cnd] } {
	    incr cnd
	    lset T $pos $cnd
	    incr pos
	} elseif { $cnd > 0 } {
	    set cnd [lindex $T $cnd-1]
	} else {
	    lset T $pos $cnd
	    incr pos
	}
    }

    set T
}


proc ? { a b } { if { $a ne $b } { puts "$a != $b" } }

? [failure-array AAACAAAAAAGCTGATAAAAGATTGCC] {0 1 2 0 1 2 3 3 3 3 0 0 0 0 1 0 1 2 3 3 0 1 0 0 0 0 0}
? [failure-array TTTTGCCGAGGACTACACCTTACGGCA] {0 1 2 3 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 2 0 0 0 0 0 0}
? [failure-array TTCTGCTCGGCGTGCATAGGGTTCAAG] {0 1 0 1 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 0 0 1 2 3 0 0 0}
? [failure-array TTTTTCTACAACTACTTCTAAAAGATT] {0 1 2 3 4 0 1 0 0 0 0 0 1 0 0 1 2 0 1 0 0 0 0 0 0 1 2}
? [failure-array ACACAGCGGATGAACTGTCGACCCTGA] {0 0 1 2 3 0 0 0 0 1 0 0 1 1 2 0 0 0 0 0 1 2 0 0 0 0 1}

#puts [string len $data]
#puts [llength [split $data {}]]
#puts [llength [failure-array $data]]
#puts [split [string trim $data] {}]

puts [failure-array $data]

