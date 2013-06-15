#!/usr/bin/env tclkit
#

source func.tcl
source unix.tcl

source codon.tcl

set data {
    ATGGCCATGGCGCCCAGAACTGAGATCAATAGTACCCGTATTAACGGGTGA
    MAMAPRTEINSTRING
}
set data [read [open ~/Downloads/rosalind_ptra.txt]]

lassign $data dna protein


foreach table [dict keys $::Codon {[1-9]*}] {
    set trial [string map { * {} } [dna2protein $dna $table]]

    if { $trial eq $protein } { puts "$table : $trial" }
}
