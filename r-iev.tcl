#!/usr/bin/env tclkit
#

source func.tcl

set data { 1 0 0 1 0 1 }
set data [read [open ~/Downloads/rosalind_iev.txt]]

lassign $data AAAA AAAa AAaa AaAa Aaaa aaaa

set x [foldr + 0 [set l [list	\
    [expr { $AAAA * 1.00 }]	\
    [expr { $AAAa * 1.00 }]	\
    [expr { $AAaa * 1.00 }]	\
    [expr { $AaAa * 0.75 }]	\
    [expr { $Aaaa * 0.50 }]	\
    ]]]

puts [expr $x*2]

