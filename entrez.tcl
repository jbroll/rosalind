
namespace eval entrez {
    set equery [list tool "John's rosalind tcl tools" email john@rkroll.com]
    set eroot http://eutils.ncbi.nlm.nih.gov/entrez/eutils

    proc esearch-xml-parse { tag end x props body } {
	variable entrez
	variable edone

	if { $tag eq "IdList" && $end } { set edone 1 }
	if { $edone || $end } { return }

	switch $tag {
	    Count -
	    RetMax -
	    RetStart -
	    QueryTranslation { dict set     entrez $tag $body }
	    Id 	{ dict lappend entrez Id $body } 
	}
    }

    proc esearch { db term } {
        variable equery
	variable eroot

	variable entrez {}
	variable edone 0

	tax::parse entrez::esearch-xml-parse [http $eroot/esearch.fcgi [dict merge $equery [list db $db term $term]]]

	set entrez
    }

    proc efetch { db id { retmode FULL } { rettype FASTA } } {
	variable equery
	variable eroot

	http $eroot/efetch.fcgi [dict merge $equery [list db $db id [join $id ,] retmode $retmode rettype $rettype]]
    }
}
