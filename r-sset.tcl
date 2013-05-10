#!/usr/bin/env tclkit
#

set data { 0 1 2 3 }
set data [read [open ~/Downloads/rosalind_sset.txt]]


foreach n $data { puts [expr ((2**$n))%1000000] }

