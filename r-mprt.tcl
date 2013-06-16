#!/usr/bin/env tclkit
#

source func.tcl
source unix.tcl
source http.tcl

source rosie.tcl

set data {
    A2Z669
    B5ZC00
    P20840_SAG1_YEAST
}
set data [read [open ~/Downloads/rosalind_mprt.txt]]


set motif {N{P}[ST]{P}}

proc mprt { motif prot } {
    set reply {}

    set motif [regsub -all {{([A-Z]*)}} $motif {[^\1]}]
#    puts $motif

    #set reply [regexp -all -inline -indices [regsub -all {{([A-Z]*)}} $motif {([^\1]+)}] $prot]

    set start 0
    while { [set start [map pair [
	    regexp -inline -start $start -indices [regsub -all {{([A-Z]*)}} $motif {([^\1])}] $prot] {
	expr [lindex $pair 0]+1 }]] ne {} } {
	lappend reply $start
    }

    set reply
}

foreach prot $data {
    if { [set indices [mprt $motif [lindex [fasta [uniprot $prot]] 1]]] ne {} } {
	puts $prot
	puts $indices
    }
}
