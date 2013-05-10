#!/usr/bin/env tclkit8.6
#
lappend auto_path $env(HOME)/lib

source func.tcl
source set.tcl


set data {
    1 2 3 4 5 6 7 8 9 10
    1 8 9 3 2 7 6 5 4 10
}
set data [read [open ~/Downloads/rosalind_sort.txt]]

proc remap { d1 d2 } {
    set i 0
    foreach x $d2 {
	set L($x) $i
	incr i
    }
    foreach x $d1 {
	lappend reply [expr $L($x)+1]
    }
    set reply
}

proc seqerrors { list } {	; # Create a list of seq error positions
    set i 0
    set l [llength $list]

    set reply {}

    set prev 0
    while { $i < $l } {
	if { [lindex $list $i] != $prev+1 && [lindex $list $i] != $prev-1 } {
	    lappend reply [expr $i-1]
	}

	set prev [lindex $list $i]
	incr i
    }

    #puts "$list : $reply"

    return $reply
}

proc reverse { list x1 x2 } {
    return [list {*}[lrange $list 0 [expr $x1-1]] {*}[lreverse [lrange $list $x1 $x2]] {*}[lrange $list [expr $x2+1] end]]
}

set d1 { 1 2 3 4 5 6 7 8 9 10 }
set d1 { 1 8 9 3 2 7 6 5 4 10 }

proc next-step { dxlist dxsort } {		; # Compute the set of next steps which progress towards a solution.
    set list {}
    set sort {}

    foreach d1 $dxlist s1 $dxsort {
	set l [llength $d1]

	set errindx [seqerrors $d1]
	#puts "$d1: err : $errindx"

	if { $errindx eq {} } { return [list {} $s1] }


	foreach i $errindx {
	    if { [lindex $d1 $i] < $l } {
		set a [lsearch $d1 [expr [lindex $d1 $i]+1]]

		if { $i < $a } {
		    incr i
		    set dx [reverse $d1 $i $a]

		    if { ![info exists X($dx)] } { 
			lappend list $dx

			set     sorts $s1
			lappend sorts $i $a
			lappend sort $sorts

			set X($dx) 1
		    }
		}
	    }

	    if { [lindex $d1 $i+1] > 1 } {
		set b [lsearch $d1 [expr [lindex $d1 $i+1]-1]]

		if { $i+1 > $b } {
		    set dx [reverse $d1 $b $i]

		    if { ![info exists X($dx)] } { 
			lappend list $dx

			set sorts $s1
			lappend sorts $b $i
			lappend sort $sorts

			set X($dx) 1
		    }
		}
	    }
	}
    }

    return [list $list $sort]
}

proc rev-dist { d1 d2 { n 0 } } {

    if { $d1 eq $d2 } { return 0 } 

    set k 0

    set d1list [list [list [remap $d1 $d2]] {}]
    set d2list [list [list [remap $d2 $d1]] {}]

    while { 1 } {
	set d1list [K [next-step {*}$d1list] [set d1list {}]]

	lassign $d1list list sorts
	if { $list eq {} } { break }

	#set d2list [K [next-step {*}$d2list] [set d2list {}]]		; # Attempted meet-in-middle
	#
	#puts [lintersect [lindex $d1list 0] [lindex $d2 0]]

	incr k
    }

    return [list $k $sorts]
}



foreach { d1 d2 } [split [string map { \n\n \n } [string trim $data]] \n] {}
set d1 [string trim $d1]
set d2 [string trim $d2]

set reply [rev-dist $d1 $d2]

lassign $reply dist sorts

puts $dist

foreach { a b } $sorts {
    puts "[expr $a+1] [expr $b+1]"
    set d1 [list {*}[lrange $d1 0 $a-1] {*}[lreverse [lrange $d1 $a $b]] {*}[lrange $d1 $b+1 end]]
}

#puts $d1
#puts $d2

