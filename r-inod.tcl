#!/usr/bin/env tclkit
#

source rosie.tcl

set data 4
set data [read [open ~/Downloads/rosalind_inod.txt]]

puts [expr $data-2]
