#!/usr/bin/env tclkit
#
# http://www.akira.ruc.dk/~keld/teaching/algoritmedesign_f03/Artikler/05/Hirschberg75.pdf

source rosie.tcl
source leven.tcl
source func.tcl

set data {
>Rosalind_39
PLEASANTLY
>Rosalind_11
MEANLY
}
set data [read [open ~/Downloads/rosalind_edit.txt]]
#set data [read [open ~/Downloads/rosalind_edit_4_dataset.txt]]

lassign [fasta $data] 1 A 2 B
puts $A
puts $B

puts [leven $A $B]
