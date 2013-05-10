#!/usr/bin/env tclkit
#

source rosie.tcl
source codon.tcl
source func.tcl

set data {
    TCATC
    TTCAT
    TCATC
    TGAAA
    GAGGA
    TTTCA
    ATCAA
    TTGAT
    TTTCC
}
set data [read [open ~/Downloads/rosalind_corr.txt]]

foreach x $data {			; # Pre compute some stuff
    set comp [dna-comp $x]		; #  reverse compliment

    incr Data($x)			; #  number of times $x and $comp appear in data
    incr Data($comp)			; # 

    set Comp($x) $comp			; # Hash $comp
}

foreach x $data {			; # Split lists of reads and error
    if { $Data($x) >= 2 } {
	lappend reads $x
    } else {
	lappend error $x
    }
}

set reads [lsort -unique $reads]	; # Uniquify reads

foreach x $error {
    foreach d $reads {
	if { [hamm $x [set corr $d]]        == 1 } { break }	; # Found hamm 
	if { [hamm $x [set corr $Comp($d)]] == 1 } { break }	; # Found hamm comp 
    }

    lappend reply $x->$corr
}

puts [join $reply \n]

