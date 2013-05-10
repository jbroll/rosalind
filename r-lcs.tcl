#!/usr/bin/env tclkit
#

source rosie.tcl


set data {
    GATTACA
    TAGACCA
    ATACA
}
set data [read [open ~/Downloads/rosalind_lcs.txt]]

proc lcs { data } {
    set min [string length [lindex $data 0]]
    set xxx [lindex $data 0]
    foreach str [lrange $data 1 end] {
	set len [string length $str]
	if { $len < $min } {
	    set min $len
	    set xxx $str
	}
    }

    set data [l- $data $xxx]

    while { $min > 0 } {
	for { set i 0 } { $i <= [string length $xxx]-$min } { incr i } {
	    set candidate [string range $xxx $i [expr $i+$min-1]]

	    foreach str $data {
		if { [set indx [string first $candidate $str]] == -1 } { break }
	    }
	    if { $indx != -1 } { break }
	}
	if { $indx != -1 } { break }
	incr min -1
    }

    set candidate
}

puts [lcs $data]
