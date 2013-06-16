
package require http


proc http { url { query {} } } {
    set try 3

    set root [join [lrange [split $url /] 0 2] /]

    if { $query eq {} } {
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
    } else {
	set T [http::geturl $url -query [::http::formatQuery {*}$query]];   http::wait $T;   upvar #0 $T state
    }


    K [http::data $T] [http::cleanup $T]
}

