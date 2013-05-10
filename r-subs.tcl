#!/usr/bin/env tclkit
#

source rosie.tcl
source func.tcl

set data { ACGTACGTACGTACGT GTA }
set data [read [open ~/Downloads/rosalind_subs.txt]]

proc subs { data sub } {
    set indx 0
    while { [set indx [string first $sub $data $indx]] != -1 } {
	incr indx
	lappend reply $indx
    }

    set reply
}

puts [subs {*}$data]
