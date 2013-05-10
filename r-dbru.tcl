#!/usr/bin/env tclkit
#

source set.tcl
source codon.tcl

set data {
    TGAT
    CATG
    TCAT
    ATGC
    CATC
    CATC
}
set data [read [open ~/Downloads/rosalind_dbru.txt]]

foreach kmer $data {
    lappend data [dna-comp $kmer]
}

set data [lsort -unique $data]

foreach kmer $data {
    puts "([string range $kmer 0 end-1], [string range $kmer 1 end])"
}
