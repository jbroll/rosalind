#!/usr/bin/env tclkit8.6
#

source func.tcl
source fib.tcl

source rosie.tcl


set data {
    >Rosalind_57
    AUAU
}
set data [read [open ~/Downloads/rosalind_cat.txt]]

set data [fasta $data]

lassign $data id prot

proc catalan { string } {
    set n 0

	#puts $string

    if { [string length $string] <= 1 } { return 1 }
    if { [string length $string] <= 2 } { 
	if { $string eq "AU" || $string eq "UA" || $string eq "CG" || $string eq "GC" } { return 1 }
	return 0
    }

    foreach i [iota 1 [string length $string] 2] {
	incr n [expr [catalan [string index $string 0][string index $string $i]] * [catalan [string range $string 1 $i-1]] * [catalan [string range $string $i+1 end]]]
    }

    set n
}
memo catalan

#puts [catalan AUUA]
#puts [catalan AUAU]
#puts [catalan AUUAAU]

#puts $prot
#puts [string length $prot]

#puts [catalan [string repeat A 300]]

puts [expr [catalan $prot]%1000000]

