#!/usr/bin/env tclkit
#

set data AAAACCCGGT
set data [read [open ~/Downloads/rosalind_revc.txt]]

set data [string map { A T T A C G G C  } [string reverse $data]]

puts $data

