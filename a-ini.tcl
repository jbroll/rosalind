#!/usr/bin/env tclkit
#

source rosie.tcl

set data AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
set data [read [open ~/Downloads/rosalind_ini.txt]]

puts [ACGT $data]
