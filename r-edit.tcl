#!/usr/bin/env tclkit
#
# http://www.akira.ruc.dk/~keld/teaching/algoritmedesign_f03/Artikler/05/Hirschberg75.pdf

source rosie.tcl
source leven.tcl
source func.tcl

set data {
    PLEASANTLY
    MEANLY
}
set data {
    1234
    1
}
#set data [read [open ~/Downloads/rosalind_edit.txt]]

lassign $data A B

puts [leven $A $B]
