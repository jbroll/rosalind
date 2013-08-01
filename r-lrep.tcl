#!/usr/bin/env tclkit
#


source func.tcl
source rosie.tcl

set data {
    CATACATAC$
    2
    node1 node2 1 1
    node1 node7 2 1
    node1 node14 3 3
    node1 node17 10 1
    node2 node3 2 4
    node2 node6 10 1
    node3 node4 6 5
    node3 node5 10 1
    node7 node8 3 3
    node7 node11 5 1
    node8 node9 6 5
    node8 node10 10 1
    node11 node12 6 5
    node11 node13 10 1
    node14 node15 6 5
    node14 node16 10 1
}
#set data [read [open ~/Downloads/rosalind_lrep.txt]]

set nodes [lassign $data str n]

#puts "$str $n"

foreach { parent child start len } $nodes {
    set here $start
    incr here -1
    incr len  -1
    #puts "$parent $child $start $len [string range $str $here $start+$len]"

    dict lappend X($parent) children $child
    dict lappend X($child)  content   $here $here+$len
}

proc dict? { args } {
    set x {}

    try { set x [dict {*}$args] } on error message {}

    return $x
}

proc follow { array name str { indent {} } } {
    upvar $array X

    set pre {}
    
    try { set pre [string range $str {*}[dict? get $X($name) content]] } on error message { }

    puts "$indent $name : $pre"

    foreach child [dict? get $X($name) children] {
	follow X $child $str "$indent  "
    }
	
}


puts $str

follow X node1 $str




