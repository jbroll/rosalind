#!/usr/bin/env tclkit8.6
#

source tax.tcl

source func.tcl
source unix.tcl
source http.tcl
source entrez.tcl

set data {
    Brent MR
    2007
}
#set data [read [open ~/Downloads/rosalind_pbmd.txt]]

lassign [map str [split [string trim $data] \n] { string trim $str }] author year

set result [entrez::esearch pubmed [subst -nocommands { "$author"[AU] AND ("$year/01/01"[PDAT] : "$year/12/31"[PDAT])}]]
puts $result

puts [tax::xml2list [entrez::efetch pubmed [lindex [dict get $result Id] end] rettype xml]]

