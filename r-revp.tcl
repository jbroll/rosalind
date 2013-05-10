#!/usr/bin/env tclkit
#

source func.tcl

source rosie.tcl
source codon.tcl

set data TCAATGCATGCGGGTCTATATGCAT
set data [read [open ~/Downloads/rosalind_revp.txt]]

foreach x [iota 0 [string length $data]-4] {
    foreach len [iota 3 7] {
	set chunk [string range $data $x $x+$len]

	if { [string length $chunk] < $len } { break }

	if { $chunk eq [dna-comp $chunk] } {
	    puts "[expr $x+1] [expr $len+1]"
	}
    }
}



