#!/usr/bin/env tclkit8.6
#

source tax.tcl

source func.tcl
source unix.tcl
source http.tcl
source entrez.tcl

set data {
    Anthoxanthum
    2003/7/25
    2005/12/27
}
set data [read [open ~/Downloads/rosalind_gbk.txt]]

lassign $data genus fr to

set result [entrez::esearch nucleotide [subst -nocommands { $genus[Organism] AND ("$fr"[PDAT] : "$to"[PDAT])}]]
puts $result

