#!/usr/bin/env tclkit
#

source func.tcl
source iter.tcl

set data {
    5
    5 1 4 2 3
}
set data [read [open ~/Downloads/rosalind_lgis.txt]]

 set n   [lindex $data 0]
 set seq [lrange $data 1 end]

# set seq [shuffle [iota 10000]]
# set seq [lreverse { 11 3 4 8 2 12 9 13 5 7 6 10 14 }]

 proc linverse { list { len {} } } {
     if { $len eq {} } { set len [llength $list] }

     map x $list { expr { $len-$x } }
 }

 iterator psort { seq } {
    set tops {}

    foreach x $seq {
	set pile [expr [lsearch -real -bisect $tops $x] + 1]

	lset tops $pile $x

	yield [list $x $pile]
    }
 }

 proc lis { seq } {
    iterate { x pile } { psort $seq } {
	if { $pile > 0 } {
	    set prev [expr [llength [dict get $piles [expr $pile-1]]]-1]
	} else {
	    set prev {}
	}

	dict lappend piles $pile [list $prev $x]
    }

    set prev 0
    foreach pile [lreverse [dict keys $piles]] {
	lappend lis [lassign [lindex [dict get $piles $pile] $prev] prev]
    }
    lreverse $lis
 }

 proc lds { seq } {
     linverse [lis [linverse $seq]] [llength $seq]
 }

 puts [lis $seq]
 puts [lds $seq]

