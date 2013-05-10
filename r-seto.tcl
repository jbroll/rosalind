#!/usr/bin/env tclkit
#

source func.tcl
source set.tcl

set data {
10
{1, 2, 3, 4, 5}
{2, 8, 5, 10}
}
set data [read [open ~/Downloads/rosalind_seto.txt]]

lassign [split [string trim $data] \n] n a b
set a [split [string map { , {} } [lindex $a 0]]]
set b [split [string map { , {} } [lindex $b 0]]]

#puts $a
#puts $b

#exit

set D [iota 1 $n]

puts "{[join [lunion      $a $b] ", "]}"
puts "{[join [lintersect  $a $b] ", "]}"
puts "{[join [ldifference $a $b] ", "]}"
puts "{[join [ldifference $b $a] ", "]}"
puts "{[join [ldifference $D $a] ", "]}"
puts "{[join [ldifference $D $b] ", "]}"

