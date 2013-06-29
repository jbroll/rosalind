
proc ::tax::xslt-proc { templates tag type props body path } {
    set xpath [join [list {*}[lrange $path 1 end] $tag] /]

    switch $type {
     O {
         array unset ::tax::xslt $xpath*
         set ::tax::xslt($xpath) $body
     }
     C {
        foreach { match template } $templates {
            if { $match eq $xpath } {
                puts -nonewline [subst $template]
            }
        }
     }
    }
}
proc ::tax::xslt-get { xpath } {
    if { [info exists ::tax::xslt($xpath)] } { return $::tax::xslt($xpath) }

    return
}

proc ::tax::xslt { templates xml } {
    foreach { match template } $templates {
        lappend temp $match     \
                 [regsub -all {@(([a-zA-Z][a-zA-Z0-9]*/)*[a-zA-Z][a-zA-Z0-9]*)} $template {[::tax::xslt-get \1]}]
    }

    ::tax::parse [tax::new [list [list ::tax::xslt-proc $temp]]] $xml start
}

#set templates {
#    projects/project { @projects/project/id \n}
#}
#
#tax::xslt $templates [read [open projects.xml]]
