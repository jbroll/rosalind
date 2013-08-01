#!/usr/bin/env tclkit
#

source trie.tcl

set t [trie create]

set data { 
    ATAGA
    ATC
    GAT
}
#set data [read [open ~/Downloads/rosalind_trie.txt]]

foreach word $data {
    trie add t $word
}

proc print { sym n p } {
    puts "$p $n $sym"
}

proc trie::visit { trie cmd args } {
    set next   1
    set node $next

    _visit [info level] $trie $cmd {*}$args
}

proc trie::_visit { level trie cmd args } {
    upvar #$level next next
    upvar         node parent

    foreach { sym suffix } $trie {
	if { $sym ne "END" } {
	    set node [incr next]

	    {*}$cmd {*}$args $sym $node $parent
	    _visit $level $suffix $cmd {*}$args
	}
    }
}

trie visit $t print 
