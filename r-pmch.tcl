#!/usr/bin/env tclkit
#

source func.tcl
source fib.tcl

source rosie.tcl


set data {
    >Rosalind_23
    AGCUAGUCAU
}
set data [read [open ~/Downloads/rosalind_pmch.txt]]

set data [fasta $data]

lassign $data id prot

lassign [ACGU $prot] A C G U

puts "$A $C $G $U"

puts [expr [fact $A] * [fact $C]]

