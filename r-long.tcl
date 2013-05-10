#!/usr/bin/env tclkit
#

source func.tcl
source rosie.tcl


set data {
    ATTAGACCTG
    CCTGCCGGAA
    AGACCTGCCG
    GCCGGAATAC
}
#set data [read [open ~/Downloads/rosalind_long.txt]]

proc overlap { d1 d2 } {
    if { $d1 eq $d2 } { return [string length $d1] }
    
    set len [expr [string length $d1] - 1]
    set min 0
    
    foreach n [iota 0 [expr [string length $d1]/2]] {
	#puts "[string range $d1 $n end] : [string range $d2 0 $len-$n]"

	if { [string range $d1 $n end] eq [string range $d2 0 $len-$n] } {
	    return $n
	}
    }

    return -1
}

proc overlaps { data } {
    set i 0
    foreach d1 $data {
	set j 0
	foreach d2 $data {
	    if { $d1 ne $d2 } {
		if { [set x [overlap $d1 $d2]] != -1 } {
		    lappend overlaps [list $i $j $x]
		}
	    }
	    incr j
	}
	incr i
    }

    set overlaps
}

proc splice { data } {
    set overlaps [overlaps $data]

    set index [lrepeat [llength $data] -1]

    set ss {}
    set more {}

    while { $overlaps ne {} } {
	foreach overlap $overlaps {
	    lassign $overlap d1 d2 x


	    #puts "[lindex $data $d1] : [lindex $data $d2] : $ss : $index Index [lindex $index $d1] [lindex $index $d2]"

	    if { $ss eq {} } {
		set ss [lindex $data $d1]
		lset index $d1 0
		#puts "Initial ss : $ss"
	    } 


	    if { [lindex $index $d1] == -1 && [lindex $index $d2] == -1 } {
		#puts Skip
		lappend more $overlap
	    } elseif { [lindex $index $d1] == -1 } {
		set d1data [lindex $data $d1]
		set d2data [lindex $data $d2]


		#puts "$d1 $d2 : Overlap at $x : [lindex $index $d2]"

		if { $x > [lindex $index $d2] } {
		    lset index $d1 0

		    set d1star [expr $x-[lindex $index $d2]-1]

		    #puts "	$d1 $d2 $x"
		    #puts "	$index"

		    #puts "	H [string range $d1data 0 $d1star]	$d1star ($x-[lindex $index $d2])"
		    #puts "	T $ss"

		    if { $d1star > 0 } {
			set ss [string range $d1data 0 $d1star]$ss

			set d 0
			foreach i $index {
			    if { $i != -1 && $d != $d1 } {
				lset index $d [expr [lindex $index $d]+$d1star+1]
			    }
			    incr d
			}
			lset index $d1 0
		    }
		}
	    } elseif { [lindex $index $d2] == -1 } {
		set d1data [lindex $data $d1]
		set d2data [lindex $data $d2]

		set d1star [lindex $index $d1]
		set d1ends [expr $d1star + $x-1]

		set d2star [expr [lindex $index $d1] + $x]
		set d2ends [expr $d2star + [string length $d2data]]


		#puts "$d1 $d2 $x"
		#puts "	H	[string range $ss 0 $d1ends]"
		#puts "	D	[lindex $data $d2]"
		#puts "	T	[string range $ss $d2ends end] : $d2star $d2ends"

		set ss	[string range $ss 0 $d1ends][lindex $data $d2][string range $ss $d2ends end]

		lset index $d2 $d2star

	    }
	}

	set overlaps $more
	set more {}
    }

    set ss
}
proc disp { str data } {
    foreach x $data {
	puts [string repeat " " [string first $x $str]]$x
    }
}

set str GGGGTTTTCGGAGCGTCAGCCACGC
set data {
    TTCGGAGCGTC
    GCGTCAGCCAC
    GGTTTTCGGAG
    CGGAGCGTCAG
    GTCAGCCACGC
    GGGGTTTTCGG
    GAGCGTCAGCC
    TTTTCGGAGCG
}
puts $str
puts [disp $str $data]
puts [splice $data]
exit



proc mince { str n m } {
    set len [string length $str]

    for { set star 0 } { $star < $len-$n+1 } { incr star $m } {
	lappend reply [string range $str $star $star+$n]
    }

    set reply
}

#set str AGCAATGGATTAATTGCGTAAACGG





#set str ABCDEFGHIJKLMNOPQR
#set data {
#      CDEFGHIJKLMNOP
#        EFGHIJKLMNOPQR
#    ABCDEFGHIJKLM
#}

set str GGGGTTTTCGGAGCGTCAGCCACGC
set data {
    TTCGGAGCGTC
    GCGTCAGCCAC
    GGTTTTCGGAG
    CGGAGCGTCAG
    GTCAGCCACGC
    GGGGTTTTCGG
    GAGCGTCAGCC
    TTTTCGGAGCG
}

#set str TCCTAAATTATCGAAAGCTATATTG
#set data {
#    TCCTAAATTAT
#    GAAAGCTATAT
#    ATTATCGAAAG
#    AAGCTATATTG
#    CTAAATTATCG
#    TCGAAAGCTAT
#    AAATTATCGAA
#    TATCGAAAGCT
#}


foreach k { 1 2 3 4 5 6 7 8 9 10 } {
    set str [gc .40 5000]
    set data [mince $str 500 100]
    set data [shuffle $data]
    #set data [lreverse $data]

    #puts ""
    #puts $str
    #puts [disp $str $data]
    set x [splice $data]
    #puts $str
    #puts [string repeat " " [string first $x $str]]$x

    puts "$k : [string length $str] [string length $x] [expr { $str eq $x }]"
}

