#!/usr/bin/env tclkit
#
# http://www.akira.ruc.dk/~keld/teaching/algoritmedesign_f03/Artikler/05/Hirschberg75.pdf

source rosie.tcl
source func.tcl

set data {
    PLEASANTLY
    MEANLY
}
#set data [read [open ~/Downloads/rosalind_edit.txt]]

lassign $data A B


proc edit { A B } {
    set C [lcs $A $B]

    set la [string length $A]
    set lb [string length $B]
    set lc [string length $C]

    puts "$la : $A"
    puts "$lb : $B"
    puts "$lc : $C"
    puts ""

    expr { max($la, $lb) - $lc }
}

puts [edit $A $B]
