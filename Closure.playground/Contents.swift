
/*
 Closure: self contained block of code that can be passed around and used in your code. It is an unnamed function.
 */

/*
func addition(_ val1: Int, _ val2: Int) -> Int {
    val1 + val2
}
 */

let add: ((Int, Int) -> Int) = {(val1, val2) -> Int in
    val1 + val2
}

print(add(1, 2))

/** Syntax
{(parameters) -> returnType in
    // body
}
*/

/**
 Trailing closure
 */

func get(url: String, success: (String) -> (), failure: (Int) -> ()) {
    // if succeed
    success("some string")
    // else
    failure(400)
}

// Multiple trailing closures.
get(url: "https://example.com") { result in
    // success block.
} failure: { httpStatus in
    // failure block
}

/**
 Capturing values:
 - A closure can capture constant and variable from their surrounding context in which they are defined.
 - The closure can then refer to and modify the values of those constants and variables from with in their body.

 - if we assign a closure to the property of a class instance, and that closure capture the instance by refering the instance or its members, this will create a strong reference cycle between the closure and the instance.
 */

final class Person {

    let name: String
    var greetings: (() -> Void)?

    init(name: String) {
        self.name = name
    }

    func sayHello() {
        self.greetings = { // use `[weak self] in` to break strong retain cycle.
            print("Hello, \(self.name)")
        }
    }

    deinit {
        print("de-init is called on Person class.")
    }
}

// Usage
/*
var person: Person? = Person(name: "Mayank")
person?.sayHello()
person = nil
*/

/* Escaping closures */
// Those closures which are part of the function's parameter and called only after the function(returns) finish its execution.

var completionHanlders: [() -> Void] = []
func functionWithEscapingClosure(completionHanlder: @escaping () -> Void) {
    completionHanlders.append(completionHanlder)
}

func functionWithNonEscapingClosure(closure: () -> Void) {
    closure()
}

final class SomeClass {
    var val = 10

    func executeFunctions() {
        functionWithEscapingClosure {
            self.val = 100
        }

        functionWithNonEscapingClosure {
            val = 200
        }
    }
}

let sc = SomeClass()
sc.executeFunctions()
print("value of val after executing non-escaping closure -> ", sc.val)
completionHanlders[0]()
print("value of val after executing escaping closure -> ", sc.val)

/*
struct SomeStructure {
    var val = 10

    mutating func executeFunctions() {
        functionWithEscapingClosure { // ERROR: escaping closure can’t capture a mutable reference to self when self is a instance of structure or enumeration.
            self.val = 100
        }

        functionWithNonEscapingClosure {
            val = 200
        }
    }
}
*/

// Autoclosure
// - special kind of closure that automatically wraps an expression in a closure without explicitly writing `{}`.
func performAction(_ action: @autoclosure () -> Bool) {
    if action() {
        print("Action was successful.")
    } else {
        print("Action failed.")
    }
}

performAction(5 > 3)

func logError(_ message: @autoclosure () -> String) {
    print("Error: \(message())")
}

logError("Something went wrong!")
