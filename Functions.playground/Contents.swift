
print("Hello, World!") // by default separator is a single whitespace and terminator is \n.
print("Hello", "World", separator: ", ", terminator: "!\n")

print("Hello", "World", terminator: "") // terminator is empty string and not line feed so next print will come on the same line.
print("\r") // carriage return intentional
print("Hello", "world", separator: "-") // Now separator is not a whitespace, but a hyphen.

print("Swift", "is", "awesome", separator: "-", terminator: "!\n")

func someFunction(argumentLabel parameterName: String) { // argumentLabel: used at calling side, parameterName: used inside function.

}

// variadic paramters
// used to pass varying number of parameters(0 to n numbers.)
// Inseert ... after parameter type name.
// It will be available as constant array.
func anotherFunction(numbers: Double...) {

}

/** InOut parameters.
 - Can't pass constants or literals as a parameter.
 - Can't use default parameters values.
 - Variadic parameters can't be marked as in-out.
*/

var a = 0, b = 1
func swap(val1: inout Int, val2: inout Int) {
    let temp = val1
    val1 = val2
    val2 = temp
}

swap(val1: &a, val2: &b)
print("a: \(a), b: \(b)")
