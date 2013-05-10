#!/usr/bin/env tclkit
#

source func.tcl

set data {
    ACGTACGTGACG
    GTA
}
set data [read [open ~/Downloads/rosalind_sseq.txt]]

proc sseq { data str } {
    set indx 0
    foreach c [split $str {}] {
	set indx [string first $c $data $indx]

	lappend reply $indx
	incr indx
    }

    map x $reply { expr { $x+1 } }

puts [sseq {*}$data]

