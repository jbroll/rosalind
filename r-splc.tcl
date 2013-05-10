#!/usr/bin/env tclkit
#

source func.tcl
source codon.tcl

set data {
    ATGGTCTACATAGCTGACAAACAGCACGTAGCAATCGGTCGAATCTCGAGAGGCATATGGTCACATGATCGGTCGAGCGTGTTTCAAAGTTTGCGCCTAG
    ATCGGTCGAA
    ATCGGTCGAGCGTGT
}
set data [read [open ~/Downloads/rosalind_splc.txt]]

proc splice { data args } {
    set ions $args

    set xmap [join [map x $ions n [iota 0 [expr [llength $ions]-1]] { list $x {} }]]

    set mrna [string map { T U } [string map $xmap $data]]
    string map { X {} } [string map $::codon $mrna]
}


puts [splice {*}$data]

