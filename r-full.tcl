#!/usr/bin/env tclkit
#

source func.tcl

source rosie.tcl
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
    1988.21104821
    610.391039105
    738.485999105
    766.492149105
    863.544909105
    867.528589105
    992.587499105
    995.623549105
    1120.6824591
    1124.6661391
    1221.7188991
    1249.7250491
    1377.8200091
}
#set data [read [open ~/Downloads/rosalind_full.txt]]

set ions [lsort -r [lassign $data P]]
set nion [llength $ions]

# After sorting the smaller half must be paired in order
# with the larger half
#
set pairs [map 1 [lrange $ions 0 [expr $nion/2-1]] 2 [lreverse [lrange $ions [expr $nion/2] end]] { list $2 $1 }]

set prev [lindex [lindex $pairs 0] 0]
puts $prev
set diffs [map pair [lrange $pairs 1 end] { lassign $pair 1 2; K [expr { $prev - $1 }] [set prev $1] } ]

set prots [map p $diffs { lookup $p .001 $::ISOMassList }]

puts $pairs
puts $diffs
puts $prots
exit



puts [expr { ([llength $ions]-2)/2.0 }]

set diff [map ion $ions { expr $P-$ion }]

puts [lsort -r $ions]
puts [lsort -r $diff]

exit

set xions [map { x y } [join [prod $ions $ions list]] { 
    if { abs(($x+$y)-$P) > 0.001 } { continue } 
    
    list $x $y
    }]


set M [lindex $xions 0 0]

foreach { m x } [join [lrange $xions 1 end]] {
    puts "$m : $x"

    set w [expr $m-$M]
    set p [lookup $w .001 $::ISOMassList]

    lappend reply $p

    set M $m
}


puts $reply

