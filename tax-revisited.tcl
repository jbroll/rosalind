 ############################################################
 #
 # Based heavily on Stephen Uhler's HTML parser in 10 lines
 # Modified by Eric Kemp-Benedict for XML
 #
 # Turn XML into TCL commands
 #   xml     A string containing an html document
 #   cmd     A command to run for each html tag found
 #   start   The name of the dummy html start/stop tags
 #
 # Namespace "tax" stands for "Tiny API for XML"
 #
 
 namespace eval tax {
     # Initialise the global state
     variable TAX
     if {![::info exists TAX]} {
        array set TAX {
            idgene        0
        }
     }
     namespace export new parse
 }
 
 proc ::tax::__cleanprops { props } {
    set name {([A-Za-z_:]|[^\x00-\x7F])([A-Za-z0-9_:.-]|[^\x00-\x7F])*}
    set attval {"[^"]*"|'[^']*'|\w}; # "... Makes emacs happy
	return [regsub -all -- "($name)\\s*=\\s*($attval)" \
	    [regsub "/$" $props ""] "\\1 \\4"]
 }



 # Core of the TAX parser, XML parser in 10 lines, magic!
 proc tax::parse {cmd xml {start docstart}} {
     regsub -all \{ $xml {\&ob;} xml
     regsub -all \} $xml {\&cb;} xml
     set exp {<(/?)([^\s/>]+)\s*([^/>]*)(/?)>}
     set sub "\}\n$cmd {\\2} \[expr \{{\\1} ne \"\"\}\] \[expr \{{\\4} ne \"\"\}\] \
             \[regsub -all -- \{\\s+|(\\s*=\\s*)\} {\\3} \" \"\] \{"
     regsub -all $exp $xml $sub xml
     eval "$cmd {$start} 0 0 {} \{$xml\}"
     eval "$cmd {$start} 1 0 {} {}"
 }
 
 
 # Internal function that keeps track of the tag calling tree and
 # merges the open/close arguments into one.
 proc tax::__callbacker {id cmd tag cl selfcl props bdy} {
     set varname "::tax::cx_${id}"
     upvar \#0 $varname CONTEXT
 
     set tagpath $CONTEXT(lvl)
     if { $selfcl } {
        set type "OC"
     } elseif { $cl } {
        set CONTEXT(lvl) [lrange $CONTEXT(lvl) 0 end-1]
        set tagpath $CONTEXT(lvl)
        set type "C"
     } else {
        if { [string index $tag 0] ne "?" } {
            lappend CONTEXT(lvl) $tag
        }
        set type "O"
     }
 
     eval "$cmd $tag $type \{$props\} \{$bdy\} \{$tagpath\}"
 
     if { [string first "C" $type] >= 0 && [llength $CONTEXT(lvl)] == 0 } {
        unset CONTEXT
     }
 }
 
 
 # Calling this will return a command that complies to the original TAX
 # callback format and allows the command passed as an argument to
 # comply to the new argument list.
 proc tax::new {cmd} {
     variable TAX
 
     set id [incr TAX(idgene)]
     set varname "::tax::cx_${id}"
     upvar \#0 $varname CONTEXT
     set CONTEXT(id) $id
     set CONTEXT(lvl) ""
 
     return "::tax::__callbacker $id $cmd"
 }
 
 
 # Example procedure that complies to the new callback argument list.
 # This procedure simply dumps back the original XML file almost as is.
 proc tax::output { tag type props bdy tree } {
     # Get rid of XML header information, just duplicate it
     if { [string index $tag 0] eq "?" } {
        puts "<$tag $props>"
        return
     }
     # The first tag is a false "docstart" tag, ignore it.
     if { [llength $tree] == 0 } {
        return
     }
 
     if { $type == "C" } {
        puts "</$tag>"
     } else {
        puts -nonewline "<$tag"
        if { [llength $props] >= 0 } {
            array set properties $props
            foreach p [array names properties] {
                puts -nonewline " $p=\"$properties($p)\""
            }
        }
        if { $type == "O" } {
            if { [string trim $bdy] eq "" } {
                puts ">"
            } else {
                puts -nonewline ">$bdy"
            }
        } else {
            puts " />"
        }
     }
 }
