
proc codon-maperev { table } { map { x y } { list $y $x } }
memo codon-maperev						; # Cache these as necessary.

proc dna2rna     { data } { string map { T U }  $data }
proc rna2protein { data { table 1 } } { string map [dict get $::Codon $table] $data }
proc dna2protein { data { table 1 } } { rna2protein [dna2rna $data] $table }

proc protein2rna { data { table 1 } } { string map [codon-maprev [dict get $::Codon $table]] $data }
proc protein2dna { data { table 1 } } { rna2dna[protein2rna $data $table] }

proc dna-comp { data } { string map { A T T A C G G C  } [string reverse $data] }

# Read in and parse the NIH codon tables. : ftp://ftp.ncbi.nih.gov/entrez/misc/data/gc.prt
# Remove comments so that we are left with just the relevant data structure.
#
set gc.prt [regsub -all {::=|,| -- } [regsub -all -line ^--.*$ [cat gc.prt] {}] {}]

proc Genetic-code-table { tables } {
    foreach table $tables {
	set names {}
	foreach { item value } $table {

	    # Concatenate all the "name" attributes into "names".
	    #
	    switch $item {
		name -
		id { lappend names {*}[map str [split [string map { \n " " } $value] ";"] { string trim $str }] }
	    }
	    dict with table {}		; # Get all the attributes as local vars.

	    # I like the codon tables to be RNA based.
	    #
	    set Base1 [dna2rna $Base1]
	    set Base2 [dna2rna $Base2]
	    set Base3 [dna2rna $Base3]

	    # Construct the RNA to protein map.
	    #
	    set map [join [map p [split $ncbieaa {}] b1 [split $Base1 {}] b2 [split $Base2 {}] b3 [split $Base3 {}] {
		list $b1$b2$b3 $p
	    }]]

	    # Store a reference to the map from each name in the global Codon dict
	    #
	    foreach name $names {
		dict set ::Codon $name $map
	    }
	}
    }
}

eval ${gc.prt}				; # Evaluate the data structure.

