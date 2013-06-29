#!/usr/bin/env tclkit8.6
#

source tax.tcl

source func.tcl
source unix.tcl
source http.tcl

source string.tcl

source rosie.tcl

set data { 
    @SEQ_ID
    GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT
    +
    !*((((***+))%%%++)(%%%%).1***-+*****))**55CCF>>>>>>CCCCCCC65
}
set data [read [open ~/Downloads/rosalind_tfsq.txt]]

echo [list2fasta [join [map { id prot qual } [fastq $data] { list $id $prot }]]] > a-tfsq.out

