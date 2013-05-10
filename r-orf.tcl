#!/usr/bin/env tclkit
#

source func.tcl

source rosie.tcl
source codon.tcl

set data AGCCATGTAGCTAACTCAGGTTACATGGGGATGACCCCGCGACTTGGATTAGAGTCTCTTTTGGAATAAGCCTGAATGATCCGAGTAGCATCTCAG
set data [read [open ~/Downloads/rosalind_orf.txt]]

proc orf { data n } {
    set len [string length $data]

    string range $data $n [expr $n+int(($len-$n)/3)*3-1]
}

set reply {} 

foreach data [list $data [dna-comp $data]] {
    foreach frame [iota 0 2] {
	set protien [dna2protien [orf $data $frame]]

	set indx 0
	while { [set indx [string first M $protien $indx]] != -1 } {
	    if { [set ends [string first X $protien $indx]] != -1 } {
		lappend reply [string range $protien $indx $ends-1]
	    }
	    incr indx
	}
    }
}

puts [join [lsort -uniq $reply] \n]



