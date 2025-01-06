
/*
 Macros: Generate code at compile time.
 */

// Freestanding macro: appear on their own, without being attached to a declaration. It has (#) sign before it.
// Attached macro: modify the declaration they are attached to. It has (@) sign before it.

/* Freestanding macro */
func muFunction() {
    print("Currently running \(#function)") // this will call the function() macro from Swift standard library.
    #warning("Something's wrong") // this will call the warning(_:) macro from Swift standard library with a parameter.
}

/* Attached macro */
// without macro
struct SundaeToppings: OptionSet {
    typealias RawValue = Int
    var rawValue: Int
    static let nuts = SundaeToppings(rawValue: 1 << 0)
    static let cherry = SundaeToppings(rawValue: 1 << 1)
    static let fudge = SundaeToppings(rawValue: 1 << 2)
}

let options: SundaeToppings = [.nuts, .cherry, .fudge]

@OptionSet<Int>
struct SundaeToppings2 {
    private enum Options: Int {
        case nuts
        case cherry
        case fudge
    }
}

@attached(member)
@attached(extension, conformances: OptionSet)
public macro OptionSet<RawType>() = #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")


// This needs some extra efforts to understand.
// Right now out of scope.
