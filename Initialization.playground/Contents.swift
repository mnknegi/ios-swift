
/**
 Initialization
 */

// When a default value is assigned to a stored property or at the time of initialization, the property observers are not called.

final class Person {

    var name: String = "Mayank" {
        willSet {
            print("willSet on the name is called.")
        }
        didSet {
            print("didSet on the name is called.")
        }
    }

    var age: Int {
        willSet {
            print("willSet on the age is called.")
        }
        didSet {
            print("willSet on the age is called.")
        }
    }

    init(age: Int) {
        self.age = age
    }
}

let person = Person(age: 31)

/* Default initializer */

import UIKit

final class Circle {
    var radius: Double = 5.0
    let color = UIColor.red
}

let circle = Circle()

/* Memberwise initializer */
struct Size {
    var width: Double = 0.0
    var height: Double = 0.0

    /*
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
     */ // we no longer have access to default or memberwise initializer if we write our own custom initializer.
}

let size = Size() // Default initializer
let size1 = Size(width: 5.0) // Menberwise initializer
let size2 = Size(height: 3.0) // Menberwise initializer
let size3 = Size(width: 5.0, height: 3.0) // Menberwise initializer

/*
 Designated and convenience initializer.
 */

class Vehicle {
    var name: String
    var noOfWheels: Int

    init(name: String, noOfWheels: Int) { // super class designated initializer.
        self.name = name
        self.noOfWheels = noOfWheels
    }

    convenience init() { // super class convenience initializer - delegate-across
        self.init(name: "[ unknown ]", noOfWheels: 0)
    }

    convenience init(name: String) { // super class convenience initializer - delegate-across
        self.init(name: name, noOfWheels: 0)
    }

    convenience init(noOfWheels: Int) { // super class convenience initializer - delegate-across
        self.init(name: "[ unknown ]", noOfWheels: noOfWheels)
    }
}

class Car: Vehicle {

    var color: UIColor

    init(name: String, color: UIColor) { // designated initializer - delegate-up.
        self.color = color
        super.init(name: name, noOfWheels: 4)
    }

    override convenience init(name: String, noOfWheels: Int) { // override superclass convenience initializer - delegate-across
        self.init(name: name, color: .red)
    }

    convenience init(name: String) { // convenience initializer - delegate-across
        self.init(name: name, color: .red)
    }
}


/* Required Initializer*/
// Indicate that subclass of the class must implement that initializer.


class Shape {
    required init(name: String) {

    }
}

class Square: Shape {
    required init(name: String) {
        // some implementation.
    }
}
