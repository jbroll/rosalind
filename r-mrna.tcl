#!/usr/bin/env tclkit
#

source codon.tcl
source func.tcl


foreach C [map { x p } $codon { set p }] {
    incr codonN($C)
}

set data MA
set data [read [open ~/Downloads/rosalind_mrna.txt]]

set n 3
foreach C [split $data {}] {
    if { [info exists codonN($C)] } {
	set n [expr $n*$codonN($C)]
    }
}

puts [expr $n%1000000]
