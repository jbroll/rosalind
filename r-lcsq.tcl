#!/usr/bin/env tclkit
#
# http://www.akira.ruc.dk/~keld/teaching/algoritmedesign_f03/Artikler/05/Hirschberg75.pdf

source rosie.tcl
source func.tcl

set data {
>Rosalind_23
AACCTTGG
>Rosalind_64
ACACTGTGA
}
#set data {
#    CHIMPANZEE
#    HUMAN
#}
set data [read [open ~/Downloads/rosalind_lcsq.txt]]

set data [fasta $data]


lassign $data n1 A n2 B

#set A 1234
#set B 1224533324

#set A thisisatest
#set B testing123testing

#puts "$A	: [string length $A]"
#puts "$B	: [string length $B]"
#puts ""
puts [lcs $A $B]
