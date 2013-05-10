#!/usr/bin/env tclkit
#

source func.tcl

source rosie.tcl

set data {
    D N A
    3
}
set data [read [open ~/Downloads/rosalind_lexv.txt]]

proc alphabet { n } {
    lrange { A B C D E F G H I J K L M N O P Q R S T U V W X Y Z } 0 $n-1
}

lassign [split [string trim $data] \n] data n

foreach i [iota 1 $n] {			# Obtain all combinations of any length.
    lappend reply {*}[combi $data $i]
}

set fmap [join [map x $data y [alphabet [llength $data]] { list $x $y }]]	; # Map to and from alphabet
set rmap [join [map x $data y [alphabet [llength $data]] { list $y $x }]]

set reply [map x [lsort [map x $reply { string map $fmap $x }]] { string map $rmap $x }]

puts [join $reply \n]

