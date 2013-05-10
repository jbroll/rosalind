#!/usr/bin/env tclkit
#

set data AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
set data [read [open ~/Downloads/rosalind_rna.txt]]

set data [string map { T U } $data]

puts $data

