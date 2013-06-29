#!/usr/bin/env tclkit8.6
#

source tax.tcl

source func.tcl
source unix.tcl
source http.tcl

source string.tcl

source rosie.tcl

set data { 
    28
    @Rosalind_0041
    GGCCGGTCTATTTACGTTCTCACCCGACGTGACGTACGGTCC
    +Rosalind_0041
    6.3536354;.151<211/0?::6/-2051)-*"40/.,+%)
    @Rosalind_0041
    TCGTATGCGTAGCACTTGGTACAGGAAGTGAACATCCAGGAT
    +Rosalind_0041
    AH@FGGGJ<GB<<9:GD=D@GG9=?A@DC=;:?>839/4856
    @Rosalind_0041
    ATTCGGTAATTGGCGTGAATCTGTTCTGACTGATAGAGACAA
    +Rosalind_0041
    @DJEJEA?JHJ@8?F?IA3=;8@C95=;=?;>D/:;74792.
}
set data [read [open ~/Downloads/rosalind_phre.txt]]

set data [lassign $data quality] 				; # Get the first item in the file, its  the quality measure
set data [fastq [join $data \n]]				; # Put the file back together.

set data [map { id seq qual } $data { fastq2quality $qual }]	; # Select quality measures and convert from ASCII enconing to integers
set data [map q   $data { expr [foldr + 0 $q]/[llength $q] }]	; # Compute the average of each read.
set data [map avg $data { if { $avg >= $quality } { continue } ; set avg }]	; # Select only read >= $quality

puts [llength $data]
