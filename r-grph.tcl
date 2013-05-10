#!/usr/bin/env tclkit
#

source func.tcl

source rosie.tcl

set data {
    >Rosalind_0498
    AAATAAA
    >Rosalind_2391
    AAATTTT
    >Rosalind_2323
    TTTTCCC
    >Rosalind_0442
    AAATCCC
    >Rosalind_5013
    GGGTGGG
}
set data [read [open ~/Downloads/rosalind_grph.txt]]

set data [split [string range [string trim $data] 1 end] >]
set data [join [map item $data { list [lindex $item 0] [join [lrange $item 1 end] {}] }]]

proc overlap { data k } {
    incr k -1

    foreach { idTail strTail } $data {
	foreach { idHead strHead } $data {
	    if { $idHead eq $idTail } { continue }

	    if { [string range $strTail end-$k end] eq [string range $strHead 0 $k] } {
		puts "$idTail $idHead"
	    }
	}
    }
}

overlap $data 3

