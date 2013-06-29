#!/usr/bin/env tclkit8.6
#

source func.tcl
source fib.tcl

source rosie.tcl


set data {
    >Rosalind_92
    AUGCUUC
}
set data [read [open ~/Downloads/rosalind_mmch.txt]]

set data [fasta $data]

lassign $data id prot

lassign [ACGU $prot] A C G U

puts "$A $C $G $U"

lassign [lsort [list $A $U]] au_min au_max
lassign [lsort [list $C $G]] cg_min cg_max

puts "$au_min $au_max $cg_min $cg_max"

interp alias {} ::tcl::mathfunc::fact {} fact

puts [expr fact($au_max)/fact($au_max-$au_min) * fact($cg_max)/fact($cg_max-$cg_min)]

