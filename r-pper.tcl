#!/usr/bin/env tclkit
#

source rosie.tcl

set data {
     2 1 
     3 2
    21 7
}
set data [read [open ~/Downloads/rosalind_pper.txt]]


foreach { n m } $data {
    puts [expr [fact $n $m]%1000000]
}

