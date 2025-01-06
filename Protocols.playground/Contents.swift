
// Protocols

/** Define requirement that conforming type must implement. **/

/*
 - It is a blueprint of methods, properties and other requirement that suit a particulat task or piece of functionality.
 - The protocol can be adopted by any class, structure or enumeration to provide the actual implementation for the reqirements.
 - Any type that satisfies the requirements fo the protocol is said to `conform` to that protocol.
 */

import Foundation

protocol Vehicle {

    // Requirements
    var brand: String { get }
    func engine()
    func speed() -> Double
}

final class Car: Vehicle {

    // Requirement implementation.
    var brand: String = "Hyundai"

    func engine() {
        print("1.25L Kappa")
    }
    
    func speed() -> Double {
        100.0
    }
}


/**
 # Property Requirements

 - A protocol can define a instance property or a type property as its requirement which needs to be implemented by the conforming type.
 - The protocol doesn't specify if it is a computed property of a stored property - it only specifies the required property name and its type. It also specify if the property is gettable and settable or only gettable.
 - If the property needs to be gettable or settable, that property requirement can't be fulfilled by a constant stored property or read only computed property.
 */

/**
 # Method Requirements

 - Protocols can required any instance method or class method to be implemented by conforming type.
 - Varadic parameters are allowed. Default values, howerve, can't be specified for method parameters within a protocol's definition.
 - For structures and enumerations, sometimes it is necessary for a method to modify the instance it belongs to. For this we need to use `mutating` keyword infront of function name.
 - Classes do not use to mention mutating keyword when adopting a protocol with a mutating method.
 - Type methods are prefixed with `static` keyword inside protocol definition even if we use `class` keyword to make them Type method in our actual method implementation.
 */

protocol Turnable {
    mutating func makeAUTurn()
}

enum Direction: Turnable {
    case east, west, north, south

    mutating func makeAUTurn() {
        switch self {
        case .east:
            self = .west
        case .west:
            self = .east
        case .north:
            self = .south
        case .south:
            self = .north
        }
    }
}

/**
 # Initializer Requirements

 - A protocol can require specific initializers to be implemented by a conforming type.
 - If a class conforms to such protocol, in that case the conforming class should implement this initializer either as a designated initializer or a convenience initializer. In both the cases we need to mark the initializer implementation with a `required` modifier.
 - The required modifier insures that we are providing an explicit and inherited implementation of the initializer requirement on all the subclasses of the conforming class, such that they also conform to the protocol.
 - Those classes which are marked with final keyword, we don't need to explicitly mention required keyword for those classes as they can't be further subclasses.
 - If a subclass overrides a designated initializer from a superclass and also provided the implementation for matching initializer requirement from a protocol, in that case the initializer will be marked with `required override` modifier.
 */

protocol SomeProtocol {
    init(someProperty: String)
}

class SomeClass: SomeProtocol {
    required init(someProperty: String) {
        // required keyword is necessary if we are creating a designated or convenience initializer for this class.
    }
}

class SomeSubclass: SomeClass {
    init() {
        super.init(someProperty: "")
    }

    required init(someProperty: String) {
        fatalError("init(someProperty:) has not been implemented")
    }
}

class SomeBaseClass {
    init(someProperty: String) {}
}

class SomeChildClass: SomeBaseClass, SomeProtocol {
    required override init(someProperty: String) {
        super.init(someProperty: someProperty)
    }
}


/**
 # Failable initializer Requirements

 - A failable initializer requirement can be satisfied by failable or a non-failable initializer on a conforming type.
 - A non-failable initializer requirement can be satisfied by a non-failable or a explicitly unwrapped failable initializer.
*/

protocol Failable {
    init?(someValue: String)
}

class FailableClass: Failable {
    required init?(someValue: String) {
        // requirement can be satisfied by failable or non-failable initializer.
    }

    // and also
    /*
    required init(someValue: String) {

    }
     */
}


/**
 # Delegation

 - Delegation is a design pattern that enables a class or a structure to handoff(or delegate) some of its responsibilities to a instance of another type.
 - This design principle is implemented by defining a protocol that encapsulates the `delegated responsibilities`, such as conforming type (known as delegate) is guaranteed to provide the functionality that has been delegated.
 - Delegation can be used to respond to particular action, or to retrieve data from particular source without needing to know the underlaying type of that source.

 - Conforming type is called `delegate`
 */


/**
 # Adding Protocol conformance with an extension

 - We can extend the existing type to adopt and conform to a new protocol, even if we don't have access to the source code.
 - Extensions can add new properties, methods and subscripts to an existing type, and are therefore able to add any requirement that the new protocol may demand.
 */

/**
 # Conditionally conforming to a protocol

 - We can make a generic type conditionally conform to a protocol by adding a constaint while extending the type.
 - These constraints can be added by using generic where clause after the name of the protocol.
 */

protocol TextRepresentable {
    var textDescription: String { get }
}

extension Array: TextRepresentable where Element: TextRepresentable {
    var textDescription: String {
        let itemsAsText = self.map { $0.textDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}


/**
 # Adopting a protocol using a Synthesized Implementation

 - Swift automatically provides protocol conformance for Equatable, hashable and comparable.
 - Using the synthesized implementation means we don't have to provide protocol implementation and thus do not have to write boilerplate code.

 - Swift provides a synthesized implementation of Equatable for the following kind of custom types:
    + Structures that have only stored properties that conform to the Equatable protocol.
    + Enumerations that have only associated types that conform to Equatable protocol.
    + Enumeration that have no associated types.

 - Swift provides a synthesized implementation of Hashable for the following kind of custom types:
    + Structures that have only stored properties that conform to the Hashable protocol.
    + Enumerations that have only associated types that conform to Hashable protocol.
    + Enumeration that have no associated types.

 - Swift provides a synthesized implementation of Comparable for the following kind of custom types:
    + Enumerations that don't have a raw value.
    + Enumeration with associated types, they must all conform to Comparable protocol.
 */


/**
 # class-only Protocols

 - We can limit the protocol adoption to class types(and not structures and enumerations) by adding AnyObject protocol to a protocol's inheritance list.
 - We can use class only protocol when the behaviour defined by the protocol's requirements requires that a conforming type has reference semantics rather than value semantics.
 */

/**
 # Protocol Composition

 - Sometimes it is required by a type to conform to multiple protocols at the same time. We can combine multiple protocols into a single requirement with a protocol composition.
 - Protocols in protocol composition are separated by amprasand (&).
 - A protocol composition can contain one class type, which we can use to specify a required superclass.
*/

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

class User: Named, Aged {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

/*
class User: Named & Aged {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
*/

func wishHappyBirthday(_ user: Named & Aged) {
    print("Happy birthday \(user.name), you're \(user.age)")
}

class Location {
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    let name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name) with lat: \(location.latitude) and long: \(location.longitude)")
}


/**
 # Optional Protocol Requirements

 - The requirements are prefixed by `optional` modifier.
 - Both the protocol and optional requirement needs to be marked as `@objc` attribute.
 - @Objc protocols can be adopted only by the class and not by structures and enums.
 */

@objc protocol OptionalProtocol {
    @objc optional func optionalProtocolMethod()
    @objc optional var optionalProtocolProperty: String { get }

    func requiredFunction()
    var requiredProperty: String { get }
}

class OptionalProtocolExample: OptionalProtocol {

    // only required func and properties goes here.
    func requiredFunction() {
        // something
    }
    
    var requiredProperty: String = ""
}


/**
 # Protocol Extension

 - Protocols can be extended to provide implementation for initializers, methods, properties, subscripts and computed properties to conforming types.
 - This allow us to define the behaviour on the protocol itself rather then implementing it on the conforming type.
 */

protocol Machine {
    func someFunction()
}

extension Machine {
    func dispatch() {
        print("Dispatching...")
    }
}

class CoffeeVendingMachine: Machine {
    func someFunction() {
        // code
    }
}

let coffeeVendingMachine = CoffeeVendingMachine()
coffeeVendingMachine.dispatch()


/**
 # Protocol Default Implementation

 - We can use protocol extensions to provide default implementation for methods and computed properties requirements of a protocol.
 - If a conforming type provides its own implementation of a required method or property, the implementation will be used instead of the one provided by the extension.
 */


/**
 # Adding constraint to a protocol extension

 - We can specify a constraint on a protocol extension that conforming type must satisfy before the methods and the properties of the extension are available.
 */
