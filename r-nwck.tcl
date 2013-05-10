#!/usr/bin/env tclkit
#

source rosie.tcl

set data {
    (cat)dog;
    dog cat

    (dog,cat);
    dog cat

    (,,dog,cat);
    dog cat
}

#set data [read [open ~/Downloads/rosalind_nwck.txt]]

proc newick { str } {
    puts $str
    set str "newick:node -children [string map { ; {} { } {} ( {[newick:node -children } ) {] -name } } $str]"

    puts $str
    eval $str
}
proc newick:node { args } {
    set childlist {}
    set nodename  {}

    switch [llength $args] {
	2 { set childlist [lindex $args 1] }
	3 {
	    if { [lindex $args 2] eq "-name" } { # children, no name
		set childlist [lindex $args 2]
	    }
	    if { [lindex $args 1] eq "-name" } { # name, no children
		set nodename  [lindex $args 2]
	    }
	}
	4 {
	    set childlist [lindex $args 1]
	    set nodename  [lindex $args 3]
	}
    }

    return [list name $nodename children [split $childlist ,]]
}

foreach { tree pair {} } [split [string trim $data] \n] {
    puts [newick [string trim $tree]]
	exit
}

