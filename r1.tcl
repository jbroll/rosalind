#!/usr/bin/env tclkit
#

set data AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
set data [read [open ~/Downloads/rosalind_dna.txt]]

set A [string map { G {} C {} T {} } $data]
set C [string map { A {} G {} T {} } $data]
set G [string map { A {} C {} T {} } $data]
set T [string map { A {} G {} C {} } $data]

puts "[string length $A] [string length $C] [string length $G] [string length $T]"
