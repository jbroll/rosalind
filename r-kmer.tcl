#!/usr/bin/env tclkit
#

source func.tcl

source rosie.tcl

set data {
    >Rosalind_6431
    CTTCGAAAGTTTGGGCCGAGTCTTACAGTCGGTCTTGAAGCAAAGTAACGAACTCCACGG
    CCCTGACTACCGAACCAGTTGTGAGTACTCAACTGGGTGAGAGTGCAGTCCCTATTGAGT
    TTCCGAGACTCACCGGGATTTTCGATCCAGCCTCAGTCCAGTCTTGTGGCCAACTCACCA
    AATGACGTTGGAATATCCCTGTCTAGCTCACGCAGTACTTAGTAAGAGGTCGCTGCAGCG
    GGGCAAGGAGATCGGAAAATGTGCTCTATATGCGACTAAAGCTCCTAACTTACACGTAGA
    CTTGCCCGTGTTAAAAACTCGGCTCACATGCTGTCTGCGGCTGGCTGTATACAGTATCTA
    CCTAATACCCTTCAGTTCGCCGCACAAAAGCTGGGAGTTACCGCGGAAATCACAG
}
set data [read [open ~/Downloads/rosalind_kmer.txt]]

set data [split [string range [string trim $data] 1 end] >]
set data [join [map item $data { list [lindex $item 0] [join [lrange $item 1 end] {}] }]]

set data [lindex $data 1]


set kmers [combi { A C G T } 4]
set i 0
foreach kmer $kmers {
    set hash($kmer) $i
    incr i
}
set reply [lrepeat [llength $kmers] 0]

foreach i [iota 0 [string length $data]-4] {
    set kmer [string range $data $i $i+3]

    lset reply $hash($kmer) [expr [lindex $reply $hash($kmer)]+1]
}

puts $reply


