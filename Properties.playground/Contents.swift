
struct Point {
    var x: Int
}

var point1 = Point(x: 0)
point1.x = 10

let point2 = Point(x: 1)
//point2.x = 20 This will produce an compile time error.

class Size {
    var width: Double

    init(width: Double) {
        self.width = width
    }
}

var point3 = Size(width: 0)
point3.width = 30

let point4 = Size(width: 1)
point4.width = 40 // This will not produce any error.

/*
 Computed properties:
 - Doesn't store any value.
 - provides getter and an optional setter method to retrieve and set other properties value indirectly.
 */

/*
 Read Only Computed property
 - no setter only getter and is always `var`.
 */

/*
 Property Observers
 - Respond to changes in the property's value.
 - Property observers are call everytime even when new property is same as old one.
 - Can add property observers with
    + Stored properties we can define.
    + Stored properties we can inherit.
    + Computed properties we can inherit.
 - For the computed properties we define, use the setter to observe and respond to the value changes.
 - willSet(newValue) & didSet(oldValue).
 */

class Temperature { // Example property observers for stored properties.

    /*
    init(celsius: Double) {
        self.celsius = celsius
    }

     observers never call when property is set during initialization.
     */

    var celsius: Double = 0.0 {
        willSet(newTemperature) {
            print("The new temperature in celsius is: \(newTemperature)")
        }
        didSet {
            print("Temperature changes from \(oldValue) to \(celsius)")
        }
    }
}

let temp = Temperature()
temp.celsius = 25.0
temp.celsius = 30.0

class Parent {
    var value: Int = 0
}

class Child: Parent { // Example property observers for inherited stored properties.
    override var value: Int {
        willSet {
            print("Child: Value will change from \(value) to \(newValue)")
        }
        didSet {
            print("Child: Value changed from \(oldValue) to \(value)")
        }
    }
}

let obj = Child()
obj.value = 10
obj.value = 20

class Vehicle {
    var name: String {
        get {
            "Vehicle"
        }
        set {
            print("vahicle is : \(newValue)")
        }
    }
}

class Car: Vehicle {
    override var name: String {
        willSet {
            print("Child: Value will change from \(name) to \(newValue)")
        }
        didSet {
            print("Child: Value changed from \(oldValue) to \(name)")
        }
    }
}

let car = Car()
car.name = "Hyundai"

import Foundation

/* Property Wrapper */
@propertyWrapper
struct PersistentStore<Value> {
    let key: String
    let defaultValue: Value

    var wrappedValue: Value {
        get {
            UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

final class FeatureToggle {
    @PersistentStore(key: "isFeatureEnabled", defaultValue: false)
    var isFeatureEnabled: Bool
}

let toggle = FeatureToggle()
toggle.isFeatureEnabled

toggle.isFeatureEnabled = true
toggle.isFeatureEnabled
