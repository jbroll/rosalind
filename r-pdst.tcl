#!/usr/bin/env tclkit
#

source rosie.tcl
source func.tcl

set data {
>Rosalind_9499
TTTCCATTTA
>Rosalind_0942
GATTCATTTC
>Rosalind_6568
TTTCCATTTT
>Rosalind_1833
GTTCCATTTA
}
set data [read [open ~/Downloads/rosalind_pdst.txt]]

set data [fasta [string trim $data]] 

proc p-dst { data1 data2 } {
    set k [foldr + 0 [map x [split $data1 {}] y [split $data2 {}] { expr { $x ne $y } }]]
    expr { $k/double([string length $data1]) }
}

foreach { name1 data1 } $data {
    set row {}
    foreach { name2 data2 } $data {
	lappend row [p-dst $data1 $data2]
    }
    lappend reply $row
}

puts [join $reply \n]

