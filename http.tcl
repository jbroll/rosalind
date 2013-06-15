
package require http

source dict.tcl


proc http { url } {
    set try 3

    set root [join [lrange [split $url /] 0 2] /]
    while { $try } {
	set T [http::geturl $url];   http::wait $T;   upvar #0 $T state

	array set headers $state(meta)

	if { [info exists headers(Location)] } {
	    http::cleanup $T
	    set url $headers(Location)

	    if { [string index $url 0] eq "/" } { set url $root$url }

	    array unset headers
	}

    	incr try -1
    }

    K [http::data $T] [http::cleanup $T]
}

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

proc uniprot { prot { type .fasta } { root http://www.uniprot.org/uniprot } } {
    if { [file exists .uniprot/$prot$type] } { return [cat .uniprot/$prot$type] }

    file mkdir .uniprot
    echo [http $root/$prot$type] > .uniprot/$prot$type
}


