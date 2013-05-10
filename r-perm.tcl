#!/usr/bin/env tclkit
#

source rosie.tcl
source func.tcl


set data 3
set data [read [open ~/Downloads/rosalind_perm.txt]]

set perm [perm [iota 1 $data]]
puts [llength $perm]
puts [join $perm \n]




