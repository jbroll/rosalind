#  trie.tcl --
#
#       Simple implementation of tries in Tcl.
#

package require Tcl     8.5
package provide trie    0.3

namespace eval ::trie {
    namespace export {[a-z]*}
    namespace ensemble create

    # create an empty trie
    proc create {} { dict create }
    # add a word to a trie contained in trieVar
    proc add {trieVar word} {
        upvar 1 $trieVar trie
        dict set trie {*}[split $word ""] END {}
    }
    # check if a given word is contained in a trie
    proc contains {trie word} {
        dict exists $trie {*}[split $word ""] END
    }
    # get the sub-trie of all words corresponding to a given prefix
    proc get {trie {prefix ""}} {
        if {$prefix eq ""} { return $trie }
        if {![dict exists $trie {*}[split $prefix ""]]} { return {} }
        dict get $trie {*}[split $prefix ""]
    }
    # iterate through all words in a trie calling a callback for each one. The
    # callback will be called with the string of each word.
    proc words {trie cmd {prefix ""}} {
        set tries [list [get $trie $prefix] $prefix]
        set i 0
        while {[llength $tries] > $i} {
            set trie [lindex $tries $i]
            set prefix [lindex $tries [incr i]]
            # set tries [lassign $tries trie prefix] ;# VERY slow!
            if {[dict exists $trie END]} { 
                uplevel 1 [linsert $cmd end $prefix]
            }
            dict for {k v} $trie {
                lappend tries $v $prefix$k
            }
            incr i
        }
    }
    # remove a word from a trie
    proc remove {trieVar word} {
        upvar 1 $trieVar trie
        if {![contains $trie $word]} { return }
        dict unset trie {*}[split $word ""] END
        # Could/should compact the trie at this point if no other words with
        # this word as a prefix.
    }
    # count the number of words in the trie
    proc size {trie {prefix ""}} {
        set count 0
        words $trie count $prefix
        return $count
    }
    
    # private helpers
    proc count {args} {
        upvar 1 count var
        incr var
    }
}
