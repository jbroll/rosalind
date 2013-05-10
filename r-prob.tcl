#!/usr/bin/env tclkit
#

source func.tcl
source rosie.tcl

set data {
    ACGATACAA
    0.129 0.287 0.423 0.476 0.641 0.742 0.783
}
set data [read [open ~/Downloads/rosalind_prob.txt]]

set data [lassign $data str]

foreach gc $data {
    set G [expr    $gc/2]
    set A [expr (1-$gc)/2]

    # Map T and C into A and G
    # split the string into chars
    # Convert from A and G to $A and $G
    # Foldr over *
    # Take log10
    # Format %.3f
    #
    lappend reply [format %.3f [expr log10([foldr * 1 [map x [split [string map { T A C G } $str] {}] {
	    list [set $x]
	   }]])]]

}

puts $reply

