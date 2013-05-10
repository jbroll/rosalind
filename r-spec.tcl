#!/usr/bin/env tclkit
#

source func.tcl

source isomass.tcl


set ISOMassList [lsort -index 1 -real [map { name weight } [array get ::ISOMass] { list $name $weight }]]

proc lookup { pos tol list } {
    set this [lsearch -index 1 -sorted -real -bisect $list $pos]

    if { $this == -1 } { set this [expr [llength $list] - 1] }

    if { abs([lindex $list $this 1] - $pos) < $tol } {
	set pos [lindex $list $this 0]
    } else {
	set this [expr ($this+1) % [llength $list]]

	if { abs([lindex $list $this 1] - $pos) < $tol } {
	    set pos [lindex $list $this 0]
	}
    }

    return $pos
}

set data {
    3524.8542
    3710.9335
    3841.974
    3970.0326
    4057.0646
}
set data [read [open ~/Downloads/rosalind_spec.txt]]

set data [lsort -real $data]


set M [lindex $data 0]


foreach m [lrange $data 1 end] {
    set w [expr $m-$M]
    set p [lookup $w .001 $::ISOMassList]

    append reply $p

    set M $m
}

puts $reply
