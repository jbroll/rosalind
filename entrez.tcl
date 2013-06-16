

proc entrez-parse { tag end x props body } {
    if { $tag eq "IdList" && $end } { set ::edone 1 }
    if { $::edone || $end } { return }

    switch $tag {
	Count -
	RetMax -
	RetStart -
	QueryTranslation { dict set     ::entrez $tag $body }
	Id 	{ dict lappend ::entrez Id $body } 
    }
}

proc entrez { command db term { root http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi } } {
    set ::entrez {}
    set ::edone 0

    set query [list tool "John's rosalind tcl tools" email john@rkroll.com db $db term $term]

    switch $command {
	esearch { tax::parse entrez-parse [http $root/esearch.fcgi $query] }    
	epost {}
    }

    set ::entrez
}
