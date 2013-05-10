#!/usr/bin/env tclkit
#

source codon.tcl

set data AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA
set data [read [open ~/Downloads/rosalind_prot.txt]]

puts [string map { X {} } [string map $codon $data]]

