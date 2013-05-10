#!/usr/bin/env tclkit
#

source func.tcl
source rosie.tcl

set data { 2 1 }
#set data [read [open ~/Downloads/rosalind_lia.txt]]


set AA 1
set BB 1
set Aa 0.5
set Bb 0.5

set pairs [map x [combi { AA Aa BB Bb } 2] {
    if { [string index $x 0] eq "B" || [string index $x 1] eq "B" } { continue }
    if { [string index $x 2] eq "A" || [string index $x 3] eq "A" } { continue }
    
    set x }]


set pairs [combi $pairs 2 list]

foreach { parent child } [join $pairs] {
    set i 0
    set a [string index $child 0]
    set b [string index $child 1]

    set pA [expr (4-$[string map "$x {}" [string range $parent 0 1]Aa])/ 4]
    set pB [expr (4-$[string map "$x {}" [string range $parent 2 3]Aa])/ 4]

    foreach x [split $child {}] {

	
	incr i
    }
    set A [string range $parent 0 1]Aa
    set B [string range $parent 2 3]Bb

    count $A [string 

    puts "X $child $parent"


#    puts  "$p1 $p2 $pair"

#    set Frac($pair) [expr { [set $p1] * [set $p2] * $Aa * $Bb }]
}
exit

puts [array get Frac]

# Initial population
#
set AABB 0
set AABb 0
set AaBB 0
set AaBb 1

lassign $data generations popAaBb

set i 0
puts "$i : $AABB $AABb $AaBB $AaBb"

foreach i [iota 1 $generations] {
    lassign [list											\
	[expr { $AABB*$Frac(AABB.AABB) + $AaBB*$Frac(AaBB.AABB) + $AABb*$Frac(AABb.AABB) + $AaBb*$Frac(AaBb.AABB) }]	\
	[expr { $AABB*$Frac(AABB.AaBB) + $AaBB*$Frac(AaBB.AaBB) + $AABb*$Frac(AABb.AaBB) + $AaBb*$Frac(AaBb.AaBB) }]	\
	[expr { $AABB*$Frac(AABB.AABb) + $AaBB*$Frac(AaBB.AABb) + $AABb*$Frac(AABb.AABb) + $AaBb*$Frac(AaBb.AABb) }]	\
	[expr { $AABB*$Frac(AABB.AaBb) + $AaBB*$Frac(AaBB.AaBb) + $AABb*$Frac(AABb.AaBb) + $AaBb*$Frac(AaBb.AaBb) }]	\
    ] AABB AABb AaBB AaBb

    puts "$i : $AABB $AABb $AaBB $AaBb"
}



