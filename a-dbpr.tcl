#!/usr/bin/env tclkit8.6
#

source func.tcl
source unix.tcl
source http.tcl

set data H3SRW3
set data [string trim [read [open ~/Downloads/rosalind_dbpr.txt]]]

set p [swiss-prot [uniprot $data .txt]]

puts [join [map go [dict get $p refer GO] {
	if { [string index [lindex $go 1] 0] ne "P" } { continue }
	string range [lindex $go 1] 2 end
    }] \n]
