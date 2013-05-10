#!/usr/bin/env tclkit
#

package require http

source func.tcl
source unix.tcl
source rosie.tcl

set root http://www.uniprot.org/uniprot

proc http { url } {
    set try 3

    set root [join [lrange [split $url /] 0 2] /]
    while { $try } {
	set T [http::geturl $url];   http::wait $T;   upvar #0 $T state

	array set headers $state(meta)

	if { [info exists headers(Location)] } {
	    http::cleanup $T
	    set url $headers(Location)

	    if { [string index $url 0] eq "/" } { set url $root$url }

	    array unset headers
	}

    	incr try -1
    }

    K [http::data $T] [http::cleanup $T]
}

proc uniprot { prot { root http://www.uniprot.org/uniprot } } {
    if { [file exists .uniprot/$prot] } { return [cat .uniprot/$prot] }

    file mkdir .uniprot
    echo [http $root/$prot.fasta] > .uniprot/$prot
}
    

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
