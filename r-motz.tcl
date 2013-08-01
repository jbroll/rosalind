#!/usr/bin/env tclkit8.6
#

source func.tcl
source fib.tcl

source rosie.tcl


set data {
    >Rosalind_57
    AUAU
}
#set data [read [open ~/Downloads/rosalind_motz.txt]]

set data [fasta $data]

lassign $data id prot

proc motzkin { string } {
    set n 0

	#puts $string

    if { [string length $string] <= 1 } { return 1 }
    if { [string length $string] <= 2 } { 
	if { $string eq "AU" || $string eq "UA" || $string eq "CG" || $string eq "GC" } { return 1 }
	return 0
    }

    foreach i [iota 1 [string length $string]] {
	incr n [expr [motzkin [string index $string 0][string index $string $i]] 	\
	    	   * [motzkin [string range $string 1 $i-1]] 				\
		   * [motzkin [string range $string $i+1 end]]]
    }

    set n
}
memo motzkin

 puts [motzkin AUAU]
#puts [motzkin AUUA]
#puts [motzkin AUAU]
#puts [motzkin AUUAAU]

#puts $prot
#puts [string length $prot]

#puts [catalan [string repeat A 300]]

#puts [expr [catalan $prot]%1000000]

