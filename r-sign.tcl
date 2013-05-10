#!/usr/bin/env tclkit
#

source rosie.tcl
source func.tcl


set data 2
set data [read [open ~/Downloads/rosalind_sign.txt]]

proc lprod { d1 d2 } {
    foreach x $d1 {
	foreach y $d2 {
	    lappend reply [list {*}$x {*}$y]
    } }

    set reply
}

proc lcombi { list n { reply {} } } {
    if { $reply eq {} } { set reply $list }

    if { $n > 1 } {
	set reply [lprod $reply $list]
	incr n -1
	if { $n > 1 } {
	    set reply [lcombi $list $n $reply]
	}
    }

    set reply
}


proc perm-sign { n } {
    foreach row [perm [iota 1 $n]] {
	foreach sign [lcombi { -1 1 } $n] {

	    lappend reply [map x $row parity $sign { expr { $x * $parity } }]
	}
    }

    set reply
}

set perm [perm-sign $data]
puts [llength $perm]
puts [join $perm \n]




