#!/usr/bin/env tclkit
#

source rosie.tcl

set data {
>Rosalind_6404
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
TCCCACTAATAATTCTGAGG
>Rosalind_5959
CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
ATATCCATTTGTCAGCAGACACGC
>Rosalind_0808
CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
TGGGAACCTGCGGGCAGTAGGTGGAAT
}
set data [read [open ~/Downloads/rosalind_gc.txt]]

set data [split [string range [string trim $data] 1 end] >]

set best 0
foreach data $data {
    set id   [lindex $data 0]
    set data [join [lrange $data 1 end] {}]

    lassign [ACGT $data] A C G T

    set gc [format %.6f%% [expr double($G+$C)/[string length $data] * 100]]

    if { $best < $gc } {
	set best $gc
	set ID $id
    }
}

puts $ID
puts $best

