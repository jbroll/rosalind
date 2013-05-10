#!/usr/bin/env tclkit
#

source rosie.tcl
source func.tcl

set data { 2 2 2 }
set data [read [open ~/Downloads/rosalind_iprb.txt]]



proc pop { AA Aa aa } {
    lappend reply {*}[lrepeat $AA AA]
    lappend reply {*}[lrepeat $Aa Aa]
    lappend reply {*}[lrepeat $aa aa]

    shuffle $reply
}
proc dominant { a b } { expr { [string index $a [coin]] eq "A" || [string index $b [coin]] eq "A" } }


proc iprb-sim { data } {
    set tot 10000
    set sum 0
    foreach i [iota 1 $tot] {
	set sum [expr { $sum + [dominant {*}[lrange [pop {*}$data] 0 1]] }]
    }

    expr { $sum/double($tot) }
}

#puts [iprb-sim $data]

set pop [foldr + 0 $data]

lassign $data AA Aa aa

#puts "$pop : $AA $Aa $aa"

set x [foldr + 0 [set l [list						\
    [expr { ($AA/double($pop) * ($AA-1)/double($pop-1)) * 1.00 }]	\
    [expr { ($AA/double($pop) * ($Aa-0)/double($pop-1)) * 1.00 }]	\
    [expr { ($AA/double($pop) * ($aa-0)/double($pop-1)) * 1.00 }]	\
    [expr { ($Aa/double($pop) * ($AA-0)/double($pop-1)) * 1.00 }]	\
    [expr { ($Aa/double($pop) * ($Aa-1)/double($pop-1)) * 0.75 }]	\
    [expr { ($Aa/double($pop) * ($aa-0)/double($pop-1)) * 0.50 }]	\
    [expr { ($aa/double($pop) * ($AA-0)/double($pop-1)) * 1.00 }]	\
    [expr { ($aa/double($pop) * ($Aa-0)/double($pop-1)) * 0.50 }]	\
    ]]]

#puts $l
puts [format %.5f $x]



