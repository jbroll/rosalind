
# Memo the natural recursize solution
#
proc fib { n { x  1 } } {

    if { $n <=  0 } { return 0 }
    if { $n <=  2 } { return 1 }

    return [expr [fib [expr $n-1] $x] + [fib [expr $n-2] $x]*$x]
}
memo fib

