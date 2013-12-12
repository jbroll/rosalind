#!/usr/bin/env tclkit
#

source func.tcl
source rosie.tcl

set data {
    186.07931 287.12699 548.20532 580.18077 681.22845 706.27446 782.27613 968.35544 968.35544
    101.04768 158.06914 202.09536 318.09979 419.14747 463.17369
}
set data [read [open ~/Downloads/rosalind_conv.txt]]



lassign [split [string trim $data] \n] a b

set s1s2 [map { x y } [join [prod $a $b list]] { format %.8g [expr { $x-$y }] }]

foreach v $s1s2 { incr S($v) }
set s1s2 [lsort -real -index 1 -stride 2 [array get S]]

#puts $s1s2
#exit

puts [lindex $s1s2 end]
puts [expr abs([lindex $s1s2 end-1])]




