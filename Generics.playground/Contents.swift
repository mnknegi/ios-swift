
import Foundation
import Combine

/*
 # Generics
 */

/*

 - Generic code enables us to write flexible and reuseable functions and types that can work with any type.
 - Most of the Swift standard library is build with generic code.
 - A Generic version of a function uses a placeholder type name(e.g. `T`) instead of an actual type name(such as Int, Double).
 - The actual type of tha placeholder type is determined when the function is called.
 */

func someGenericFunction<T>(param: T) {

}


/*
 ## Type Parameters

 - In the above function placeholder type T is the type parameter.
 */


/*
 ## Generic Types

 - Swift let us define our own Generic types. These are custom classes, structures and enumeration that can work with any type.
 - Eg. Array<Element> or Dictionary<Key, Value>
 */

struct Stack<Element> {

    private var items: [Element] = []

    internal var count: Int {
        items.count
    }

    var peek: Element? {
        count != 0 ? items.last : nil
    }

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        count != 0 ? items.removeLast() : nil
    }
}

var intStack = Stack<Int>()
intStack.push(0)
intStack.push(1)
intStack.push(10)
intStack.push(11)

print("print intStack: ", intStack)
print("pop intStack: ", String(describing: intStack.pop()))

print("print intStack: ", intStack)

print("top of the intStack:", String(describing: intStack.peek))


var stringStack = Stack<String>()
stringStack.push("John")
stringStack.push("Doe")
stringStack.push("Mary")
stringStack.push("Steven")

print("print stringStack: ", stringStack)
print("pop stringStack: ", String(describing: stringStack.pop()))

print("print stringStack: ", stringStack)

print("top of the stringStack:", String(describing: stringStack.peek))


/*
## Type Constraints

 - It's sometimes useful to enforce certain type constraints on the types that can be used with generic functions and Generic types.
 - Type constraints specify that a type parameter must inherit from a specific class or conform to a particular protocol or protocol composition.
 - For example the keys for a dictionary should conform to hashable protocol.
 */

class SomeClass { }
protocol SomeProtocol { }

func someFunction<T: SomeClass, U: SomeProtocol>(_ param1: T, param2: U) { }

func performRequest<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
    Just(Data("".utf8))
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

/*
 ## Associated Types

 - When defining a protocol, sometimes it is useful to declare one or more associated types as a part of protocol definition.
 - An associated Type gives a placeholder name to a type that's used as a part of the protocol.
 - The actual type that is used as a associated type is not known until the protocol is adopted.
 */

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


/*
## Using a protocol in its Associated Type's constraint

 - A protocol can appear in its own requirement.
 */

extension Stack: Container {
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {

    func suffix(_ size: Int) -> Stack<Element> {
        var result = Stack()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
}

var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)


/*
 ## Generic where clause

 - In Swift where clause is used in conjunction with generics to specify additional constraints on type parameters.
 - These constraints can be used with generic function, method, class, structures type conforms to certain protocol or have specific associated types.
 */

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ otherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    if someContainer.count != otherContainer.count {
        return false
    }

    for i in 0..<someContainer.count {
        if someContainer[i] != otherContainer[i] {
            return false
        }
    }
    return true
}

extension Array: Container {}

var stackOfStrings = Stack<String>()
stackOfStrings.push("John")
stackOfStrings.push("Mary")
stackOfStrings.push("Steven")

let arrayOfStrings = ["John", "Mary", "Steven"]

allItemsMatch(stackOfStrings, arrayOfStrings)

class CustomClass {

}

var stackOfCustomClass = Stack<CustomClass>()
stackOfCustomClass.append(CustomClass())
stackOfCustomClass.append(CustomClass())

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

stackOfStrings.isTop("Steven")
//stackOfCustomClass.isTop() Not available as CustomClass is not conformed to Equatable protocol.

/*
 ## Contextual where clause

 - We can write a generic where clause on the method of an extension of a generic type.
 */

extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }

    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}

// Alternatively we can also write above as

/*
extension Container where Item == Int {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
}
extension Container where Item: Equatable {
    func endsWith(_ item: Item) -> Bool {
        return count >= 1 && self[count-1] == item
    }
}
*/
