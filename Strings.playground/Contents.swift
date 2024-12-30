
/**
 Strings: Unicode-compliant way to work with text.
 */


let someMultilineString = """
The White Rabbit put on his spectacles. "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""

//print(someMultilineString)

let someMultilineString2 = """
The White Rabbit put on his spectacles. "Where shall I begin,
    please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

//print(someMultilineString2) // Second line with some indentation.

//Difference between line feed and carriage return.

let someMultilineString3 = """
The White Rabbit put on his spectacles. "Where shall I begin,\nplease your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on\rtill you come to the end; then stop."
"""

//print(someMultilineString3) // /r in new MacOS behaves the same as /n.

// Unicode scaler
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496

// Extended String Delimiter
let someString = #"Line:\t 1, Line:\t 2"#
/*
print(someString)
print(#"6 times 7 is \(6 * 7)."#)
print(#"6 times 7 is \#(6 * 7)."#)
*/

/**
 Unicode Scaler Value
 - 21 bit number.
 - Swift strings fully unicode compliant.
 - {U+0061} for `a` or {U+1F425} for 🐥.
 */

/*
 Extended Grapheme Clusters:
 - It is a sequence of one or more Unicode scalars that produce a single human-readable character.
 - {U+00E9} for é and same can be represented as {U+0065} (letter e) and {U+0301} (acute accent).
 */

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // é
let regionalIndicatorForUS: Character = "\u{1F1EE}\u{1F1F3}" //  🇮🇳

/**
 String Indices:
 - Each string has an associated index type(String.Index) which corrospond to the position of each character in the string.
 - Characters take different amount of memory to store.
 - To determine a position of a character in a string, we have to iterate over each unicode scalar from the start to the end of the string.

 - startIndex
 - endIndex
 - index(before:)
 - index(after:)
 - inde(:offSetBy:)
 */

var greetings = "Hello, World"
/*
 print("first letter: ", greetings[greetings.startIndex])
 print("end letter: ", greetings[greetings.index(before: greetings.endIndex)])
 print("second letter: ", greetings[greetings.index(after: greetings.startIndex)])
 print("letter at 7th position: ", greetings[greetings.index(greetings.startIndex, offsetBy: 7)])

 print("letter at 7th position: ", greetings[greetings.index(greetings.endIndex, offsetBy: -8)])
 //print("letter at 7th position: ", greetings[greetings.index(greetings.index(before: greetings.endIndex), offsetBy: -7)])
greetings.insert("!", at: greetings.endIndex)
print(greetings)
greetings.insert(contentsOf: " How are you doing?", at: greetings.endIndex)
print(greetings)
greetings.removeSubrange(greetings.index(greetings.endIndex, offsetBy: -19)...greetings.index(before: greetings.endIndex))
print(greetings)
greetings.remove(at: greetings.index(before: greetings.endIndex))
print(greetings)

// Substring
let lastIndex = greetings.firstIndex(of: ",") ?? greetings.endIndex
//let hello = greetings[greetings.startIndex..<lastIndex]
let hello = greetings[..<lastIndex]
print(hello)
*/

// Two strings are equal if there extended grapheme clusters are equal.
// When the unicode string is written to the text file, there unicode scalars are encoded in one of the several unicode-defined scalar forms.
// UTF-8 code units can be accessed with utf-8 property. Similarly UTF-16 using utf-16 and 21 bit Unicode scalar values, equivalent to UTF-32 encoded form using unicodeScalar property.
let dog = "Dog"
for unit in dog.utf8 {
    print(unit)
}

print("*****************")

for unit in dog.utf16 {
    print(unit)
}

print("*****************")

for scalar in dog.unicodeScalars {
    print(scalar.value)
}

print("*****************")

for unit in dog.utf8CString {
    print(unit)
}
