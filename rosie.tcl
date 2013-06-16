
proc fact { n { m 0 } } {
     if { $m } { set m [expr $n-$m]
     } else { set m 1 }

     for { set y 1 } { $n > $m } { incr n -1 } { set y [expr { $y * $n }]; }

     set y
}
proc coin {} { expr { int(rand()+0.5) } }


proc ACGT { data } {
    set data [regsub {[^ACGT]} $data {}]

    set A [string map { G {} C {} T {} } $data]
    set C [string map { A {} G {} T {} } $data]
    set G [string map { A {} C {} T {} } $data]
    set T [string map { A {} G {} C {} } $data]

    list [string length $A] [string length $C] [string length $G] [string length $T]
}

proc gc { gc n } {
    for { set i 0 } { $i < $n } { incr i } {
	append data [expr { rand() < $gc ? (rand() < .5 ? "G" : "C") : (rand() < .5 ? "A" : "T") }]
    }

    set data
}

proc gc% { data } {
    lassign [ACGT $data] A C G T

    format %.6f [expr double($G+$C)/[string length $data] * 100]
}

proc prod { d1 d2 { list {} } } {
    foreach x $d1 {
	foreach y $d2 {
	    if { $list eq {} } {
		set word $x$y
	    } else {
		set word [list $x $y]
	    }
	    lappend reply $word
    } }

    set reply
}
proc combi { alphabet n { list {} } { reply {} } } {
    if { $reply eq {} } { set reply $alphabet }

    if { $n > 1 } {
	set reply [prod $reply $alphabet $list]
	incr n -1
	if { $n > 1 } {
	    set reply [combi $alphabet $n $list $reply]
	}
    }

    set reply
}

proc perm { perm { sort {} } } {
    lappend reply [set perm [perm-init $perm $sort]]
    while { [set perm [perm-next $perm]] != {} } {
	lappend reply $perm
    }

    set reply
}
proc l- {list element} {
    set pos [lsearch -exact $list $element]
    lreplace $list $pos $pos
}
proc perm-init { perm { sort {} } } { lsort {*}$sort $perm }
proc perm-next { perm } {
    #-- determine last ascending neighbors
    set last ""
    for {set i 0} {$i<[llength $perm]-1} {incr i} {
	if {[lindex $perm $i]<[lindex $perm [expr {$i+1}]]} {
	    set last $i
	}
    }
    if {$last ne ""} {
	set pivot [lindex $perm $last]
	#-- find smallest successor greater than pivot
	set successors [lrange $perm $last end]
	set minSucc ""
	foreach i $successors {
	    if {$i>$pivot && ($minSucc eq "" || $i<$minSucc)} {
		set minSucc $i
	    }
	}
	concat [lrange $perm 0 [expr {$last-1}]] [list $minSucc] \
	    [lsort [l- $successors $minSucc]]
    }
}


proc hamm { d1 d2 } {
    set hamm 0

    foreach d1 [split $d1 {}] d2 [split $d2 {}] {
	incr hamm [expr { $d1 != $d2 }]
    }

    set hamm
}

proc lookup { pos tol list } {
    set this [lsearch -index 1 -sorted -real -bisect $list $pos]

    if { $this == -1 } { set this [expr [llength $list] - 1] }

    if { abs([lindex $list $this 1] - $pos) < $tol } {
	set pos [lindex $list $this 0]
    } else {
	set this [expr ($this+1) % [llength $list]]

	if { abs([lindex $list $this 1] - $pos) < $tol } {
	    set pos [lindex $list $this 0]
	}
    }

    return $pos
}

proc lcs { A B } {
    set L {}

    foreach i [iota 0 [string length $A]] { lset L $i 0 0 }
    foreach j [iota 0 [string length $B]] { lset L 0 $j 0 }

    foreach i [iota 1 [string length $A]] {
	foreach j [iota 1 [string length $B]] {
	    if { [string index $A $i-1] eq [string index $B $j-1] } {
		lset L $i $j [expr [lindex $L $i-1 $j-1] + 1]
	    } else {
		lset L $i $j [expr max([lindex $L $i $j-1], [lindex $L $i-1 $j])]
	    }
	}
    }

    set len [lindex $L end end]

    set i [string length $A]
    set j [string length $B]

    set lcs {}
    while { [string length $lcs] < $len } {
	if { [lindex $L $i $j-1] < [lindex $L $i-1 $j] } {
	    incr i -1
	    continue
	}
	if { [lindex $L $i $j-1] > [lindex $L $i-1 $j] } {
	    incr j -1
	    continue
	}
	if { [lindex $L $i $j] == [lindex $L $i-1 $j-1]+1 } {
	    append lcs [string index $B $j-1]
	    incr i -1
	    incr j -1
	    continue
	}
	incr i -1
    }

    string reverse $lcs
}

proc lcs-len { A B } {
    set K {}

    foreach j [iota 0 [string length $B]] { lset K 0 $j 0; lset K 1 $j 0 }

    foreach i [iota 1 [string length  $A]] {
	foreach j [iota 1 [string length $B]] { lset K 0 $j [lindex $K 1 $j] }

	foreach j [iota 1 [string length  $B]] {
	    if { [string index $A $i-1] eq [string index $B $j-1] } {
		lset K 1 $j [expr [lindex $K 0 $j-1] + 1]
	    } else {
		lset K 1 $j [expr max([lindex $K 1 $j-1], [lindex $K 0 $j])]
	    }
	}
    }

    return [lindex $K 1 end]
}

# http://web.expasy.org/docs/userman.html
#
proc swiss-prot { data } {
    set date -1
    set dates { integrated sequence entry } 

    foreach line [split $data \n] {
	#dict set reply [string range $line 0 1] [string range $line 3 end]

	switch [string range $line 0 1] {
	    ID { dict set reply ID     	[lindex $line 1]
		 dict set reply status  [string map { ; {} } [lindex $line 2]]
		 dict set reply length 	[lindex $line 3]
	    }
	    AC { dict lappend reply ACs {*}[string map { ; { } } [string range $line 2 end]] }
	    DT { dict set reply date-[lindex $dates [incr date]] [string trim [lindex [split [string range $line 2 end] ,] 0]] } 
	    DE {
		set line [string map { : { } = { } ; { } } $line]
		switch [lindex $line 1] {
		    RecName {	set DEtype name  ; dict set reply name [lrange $line 3 end] }
		    AltName {	set DEtype altnames ; dict lappend reply altname [lrange $line 3 end] }
		    Short {			      dict lappend reply $DEtype [lrange $line 2 end] }
		    Flags {	dict set reply flags $line }
		    EC    {     dict set reply EC [lindex $line 2] }
		}
	    }
	    OS { dict append reply OS [string range $line 2 end] }
	    OC { dict append reply OC [string range $line 2 end] }
	    DR { set line [map str [split [string range $line 2 end] {;}] { string trim $str }]
		dict lappend2 reply refer [lindex $line 0] [lrange $line 1 end]
	    }
	    SQ { foreach { value item } [lrange [string map { ; { } } $line] 2 end] {
		    dict set reply $item $value
	    	}
	    }
	    {  } { dict append reply sequence [string map { { } {} } $line] }
	}
    }

    dict set reply AC [lindex [dict get $reply ACs] 0]
    dict set reply OS [list {*}[string map { ( {"} ) {"} } [string range [dict get $reply OS] 0 end-1]]]
    dict set reply OC [split [string map { " " {} } [string range [dict get $reply OC] 0 end-1]] ";"]

    set reply
}


interp alias {} fasta2list {} fasta
proc fasta { data } {

    set state 0
    set prot {}
    foreach line [split $data \n] {
	if { [string trim $line] eq {} } {
	    if { [string length $prot] } { lappend reply $prot }
	    set prot {}
	    continue
	}

	if { [string index $line 0] eq ">" } {
	    if { [string length $prot] } { lappend reply $prot }
	    set prot {}

	    lappend reply [string range $line 1 end]
	    set state 1

	    continue
	}
	if { $state } {
	    append prot $line
	}
    }
    if { [string length $prot] } { lappend reply $prot }

    set reply
}

proc list2fasta { list } {
    foreach { name seq } $list {
	append reply > $name \n
	append reply [join [string chunk $seq] \n] \n
    }

    set reply
}


proc uniprot { prot { type .fasta } { root http://www.uniprot.org/uniprot } } {
    if { [file exists .uniprot/$prot$type] } { return [cat .uniprot/$prot$type] }

    file mkdir .uniprot
    echo [http $root/$prot$type] > .uniprot/$prot$type
}

