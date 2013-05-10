#!/usr/bin/env tclkit8.6
#

if { 0 } {
    { 1 2 3 4 5 6 7 8 9 0 }	; # Swapping from front
    { 1 2 3 4 5 6 7 0 9 8 }
    { 1 2 3 4 5 6 7 9 0 8 }
    { 1 2 3 4 5 9 7 6 0 8 }
    { 1 2 3 4 5 7 9 6 0 8 }
    { 1 2 3 7 5 4 9 6 0 8 }
    { 1 2 3 5 7 4 9 6 0 8 }
    { 1 3 2 5 7 4 9 6 0 8 }
    { 1 3 5 2 7 4 9 6 0 8 }
    { 3 1 5 2 7 4 9 6 0 8 }

    { 3 1 5 2 7 4 9 6 0 8 }


    { 1 2 3 4 5 6 7 8 9 0 }	; # Swapping from back
    { 3 2 1 4 5 6 7 8 9 0 }
    { 3 1 2 4 5 6 7 8 9 0 }
    { 3 1 5 4 2 6 7 8 9 0 }
    { 3 1 5 2 4 6 7 8 9 0 }
    { 3 1 5 2 7 6 4 8 9 0 }
    { 3 1 5 2 7 4 6 8 9 0 }
    { 3 1 5 2 7 4 9 8 6 0 }
    { 3 1 5 2 7 4 9 6 8 0 }
    { 3 1 5 2 7 4 9 6 0 8 }

    { 3 1 5 2 7 4 9 6 0 8 }


    { 3 0 8 2 5 4 7 1 6 9 }	; ?
    { 3 0 1 7 4 5 2 8 6 9 }
    { 3 2 5 4 7 1 0 8 6 9 }
    { 3 2 5 1 7 4 0 8 6 9 }
    { 5 2 3 1 7 4 0 8 6 9 }

    { 5 2 3 1 7 4 0 8 6 9 }



    { 8 6 7 9 4 1 3 0 2 5 }

    { 8 6 7 9 4 1 3 2 0 5 }
    { 8 2 3 1 4 9 7 6 0 5 }
    { 8 2 7 9 4 1 3 6 0 5 }
    { 8 2 7 9 4 1 3 6 0 5 }
    { 8 2 7 9 4 1 3 6 0 5 }


    { 8 2 7 6 9 1 5 3 0 4 }
}

source func.tcl


set data {
    1 2 3 4 5 6 7 8 9 10
    3 1 5 2 7 4 9 6 10 8

    3 10 8 2 5 4 7 1 6 9
    5 2 3 1 7 4 10 8 6 9

    8 6 7 9 4 1 3 10 2 5
    8 2 7 6 9 1 5 3 10 4

    3 9 10 4 1 8 6 7 5 2
    2 9 8 5 1 7 3 4 6 10

    1 2 3 4 5 6 7 8 9 10
    1 2 3 4 5 6 7 8 9 10
}
set data [read [open ~/Downloads/rosalind_rear.txt]]

proc lpaste { list1 list2 } {
    foreach item1 $list1 {
	foreach item2 $list2 {
	    lappend reply [list {*}$item1 {*}$item2]
	}
    }

    set reply
}

proc lreversals { data } {

    lappend reply [lreverse $data]

    if { [llength $data] > 2 } {
	lappend reply {*}[lpaste [lindex $data 0] [lreversals [lrange $data 1 end]]]	\
	    	      {*}[lpaste [lreversals [lrange $data 0 end-1]] [lindex $data end]]
    }

    set reply
}

proc rev-dist { d1 d2 { n 0 } } {
    set l [llength $d2]
    set k 0

    set d1list [list $d1]
    
	#puts "	$d1 : $d2"

    while { 1 } {
	set nlist {}

	foreach d1 $d1list {
	    for { set i 0  } { [lindex $d1 $i] eq [lindex $d2 $i] && $i < $l } { incr i  1 } { }
	    for { set j $l } { [lindex $d1 $j] eq [lindex $d2 $j] && $j >  0 } { incr j -1 } { }

	#    puts "$d1 : $d2 : $i $j"
	    if { $j <= 0 } { break }

	    set a [lsearch $d1 [lindex $d2 $i]]
	    set b [lsearch $d1 [lindex $d2 $j]]

	    lappend nlist [list {*}[lrange $d1 0 $i-1]  {*}[lreverse [lrange $d1 $i $a]] {*}[lrange $d1 $a+1 end]]
	    lappend nlist [list {*}[lrange $d1 0 $b-1]  {*}[lreverse [lrange $d1 $b $j]] {*}[lrange $d1 $j+1 end]]
	}

	if { $j <= 0 } { break }

#	puts $nlist
	set d1list $nlist
	incr k
    }

    set k
}

proc rev-dist { d1 d2 { n 0 } } {
    set l [llength $d2]
    set k 0

    set d1list [list $d1]
    
	#puts "	$d1 : $d2"

    while { 1 } {
	set nlist {}

	foreach d1 $d1list {
	    for { set i 0  } { [lindex $d1 $i] eq [lindex $d2 $i] && $i < $l } { incr i  1 } { }
	    for { set j $l } { [lindex $d1 $j] eq [lindex $d2 $j] && $j >  0 } { incr j -1 } { }

	#    puts "$d1 : $d2 : $i $j"
	    if { $j <= 0 } { break }

	    set a [lsearch $d1 [lindex $d2 $i]]
	    set b [lsearch $d1 [lindex $d2 $j]]

	    lappend nlist [list {*}[lrange $d1 0 $i-1]  {*}[lreverse [lrange $d1 $i $a]] {*}[lrange $d1 $a+1 end]]
	    lappend nlist [list {*}[lrange $d1 0 $b-1]  {*}[lreverse [lrange $d1 $b $j]] {*}[lrange $d1 $j+1 end]]
	}

	if { $j <= 0 } { break }

#	puts $nlist
	set d1list $nlist
	incr k
    }

    set k
}

memo rev-dist
#memo lreversals


foreach { d1 d2 } [split [string map { \n\n \n } [string trim $data]] \n] {
    lappend reply [rev-dist [string trim $d1] [string trim $d2]]
}

puts [join $reply]

