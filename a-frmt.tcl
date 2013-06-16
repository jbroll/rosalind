#!/usr/bin/env tclkit8.6
#

source tax.tcl

source func.tcl
source unix.tcl
source http.tcl

source string.tcl

source entrez.tcl
source rosie.tcl

set data { FJ817486 JX069768 JX469983 }
#set data [read [open ~/Downloads/rosalind_frmt.txt]]

lassign $data genus fr to

set result [fasta [entrez::efetch nucleotide $data]]

#puts $result
#exit

proc compare-length { s1 s2 } { return [expr { [string length $s1] - [string length $s2] }] }

set result [lsort -command compare-length -stride 2 -index 1 $result]
echo [list2fasta $result] > xxx.fasta


set result [lrange $result 0 1]
set result [list2fasta $result]

puts $result

#foreach { name seq } $result { 
#    puts "[string length $seq] $name"
#}
#puts [lindex $lengths 0]

