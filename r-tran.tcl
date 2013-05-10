#!/usr/bin/env tclkit
#

source rosie.tcl

set data {
>Rosalind_0209
GCAACGCACAACGAAAACCCTTAGGGACTGGATTATTTCGTGATCGTTGTAGTTATTGGA
AGTACGGGCATCAACCCAGTT
>Rosalind_2200
TTATCTGACAAAGAAAGCCGTCAACGGCTGGATAATTTCGCGATCGTGCTGGTTACTGGC
GGTACGAGTGTTCCTTTGGGT
}
set data [read [open ~/Downloads/rosalind_tran.txt]]


lassign [fasta [string trim $data]] name1 data1 name2 data2

proc trans-trans { data1 data2 } {
    foreach xx { AT TA GC CG AC AG TC TG CA CT GA GT } { 
	set $xx 0
    }

    foreach 1 [split $data1 {}] 2 [split $data2 {}] {
	if { $1 eq $2 } { continue }
	incr $1$2
    }

    expr { ($AG+$TC+$GA+$CT)/double($AC+$AT+$TA+$TG+$CA+$CG+$GC+$GT) }
}

puts [format %.11f [trans-trans $data1 $data2]]
