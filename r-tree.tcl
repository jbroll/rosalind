#!/usr/bin/env tclkit
#

source func.tcl

set data {
    10
    1 2
    2 8
    4 10
    5 9
    6 10
    7 9
}
set data [read [open ~/Downloads/rosalind_tree.txt]]

proc llappend { list args } {
    set value [lindex $args end]
    set index [lrange $args 0 end-1]

    upvar $list L

    set V [lindex $L {*}$index]
    lappend V {*}$value
    lset L {*}$index $V
}

set data [lassign [split [string trim $data] \n] n]


set roots {}

foreach edge $data {
    lassign $edge a b 

    set aIn -1
    set bIn -1
    set i 0
    foreach root $roots {
	if { $a in $root } { set aIn $i }
	if { $b in $root } { set bIn $i }

	incr i
    }

    if { $aIn == -1 && $bIn == -1 } { lappend roots [list $a $b]; continue }
    if { $aIn == -1 } { llappend roots $bIn $a;			  continue }
    if { $bIn == -1 } { llappend roots $aIn $b;			  continue }

    if { $aIn != $bIn } {
	llappend roots $aIn [lindex $roots $bIn]
	set roots [lreplace $roots $bIn $bIn]
    }
}

set nodes [join $roots]

foreach n [iota 1 $n] {
    if { $n in $nodes } { continue }

    lappend roots $n
}

puts [expr [llength $roots]-1]

exit



1 2 8
4 10 6
5 9 7

3



