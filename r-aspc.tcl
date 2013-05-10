#!/usr/bin/env tclkit
#

source func.tcl
source rosie.tcl

set data { 6 3 }
set data [read [open ~/Downloads/rosalind_aspc.txt]]

memo fact


lassign $data n m

puts [expr [foldr + 0 [map k [iota $m $n] { expr [fact $n]/([fact $k]*[fact [expr $n-$k]]) }]] % 1000000]

