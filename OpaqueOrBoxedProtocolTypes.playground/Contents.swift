
/**
- Swift provides two ways to hide the value's type: Opaque or Boxed value types.
- Hiding type information is useful at the boundary between module and the code that calls into the module, because the underlaying type of the return value can remain private.
 */

/**
 # Opaque type
 - It preserves type identity - the compiler has access to the type information, but client of the module don't.
 - Represented by `some` keyword.
 - It allow us to return a specific type while hiding its concrete type from the calling code, expose only the protocol(interface) that it conforms to.
 */

/** ## Problem */

protocol FighterJet: Equatable {}
struct Tejas: FighterJet {}
struct F22Raptor: FighterJet {}

func indianFighterJet() -> some FighterJet { // some sort of fighter but don't know what as type is erased by the protocol.
    Tejas()
}

func americanFighterJet() -> some FighterJet {
    F22Raptor()
}

let tejasM1 = indianFighterJet()
let tejasM2 = indianFighterJet()
//let f22Raptor = F22Raptor()

print(tejasM1 == tejasM2)
//print(tejasM1 == f22Raptor) // swift doesn't let us compare these two values as the compiler knows the concrete type of the two objects.
//let array = [tejasM1, tejasM2, f22Raptor] // not allowed

import SwiftUI
// Another example
// - if we try to return a View on the basis of a condition (if condition) the compiler will throw an error
/**
func makeFooterView(isPro: Bool) -> some View {  Function declares an opaque return type `some View`, but the return statements in its body do not have matching underlying types
    if isPro {
        return Text("Hi there, PRO!") // Return type is Text
    } else {
        return VStack { // Return type is VStack<TupleView<(Text, Button<Text>)>>
            Text("How about becoming PRO?")
            Button("Become PRO", action: {
                // ..
            })
        }
    }
}
*/

// use VStack instead as a return type.
func makeFooterView(isPro: Bool) -> some View {
    return VStack {
        if isPro {
            Text("Hi there, PRO!")
        } else {
            Text("How about becoming PRO?")
            Button("Become PRO", action: {
                // ..
            })
        }
    }
}

@ViewBuilder
func makeFooterView2(isPro: Bool) -> some View {
    if isPro {
        Text("Hi there, PRO!")
    } else {
        VStack {
            Text("How about becoming PRO?")
            Button("Become PRO", action: {
                // ..
            })
        }
    }
}

// Another Example
enum Geometry {
    case circle
    case square
}

protocol Shape {
    associatedtype T
    func draw() -> T
}

struct Circle: Shape {
    func draw() -> Int {
        return 1
    }
}

struct Square: Shape {
    func draw() -> String {
        return "Hello, World!"
    }
}

/*
//Branches have mismatching types 'Circle' and 'Square'
func drawShape(_ geometry: Geometry) -> some Shape {
    switch geometry {
    case .circle:
        Circle()
    case .square:
        Square()
    }
}
 */


/*
 # Boxed protocol type
 - Can store instance of any type that conforms to the given protocol.
 - It doesn't preserve the type identity - the value's specific type isn't known until runtime, and it can change over time as different values are stored.
 */
