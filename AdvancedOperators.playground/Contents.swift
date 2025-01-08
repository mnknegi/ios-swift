
/**
 # Advanced Operators
 */

/**
 Bitwise Operator: Manipulates the individual raw data bits with in a data structure.
 */

// Bitwise NOT operator(~): Inverts all the bits in a number.

let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits

// Bitwise AND operator(&): Combines the bits of two numbers. Returns a new number whose bits are set to 1 only if the bits were equal to 1 in both the places.
let inputA: UInt8 = 0b11111100
let inputB: UInt8 = 0b00111111
let andOutputAB = inputA & inputB


// Bitwise OR operator(|): Compares the bits of two numbers. Returns a new number whose bits are set to 1 if any of the bits were equal to 1 in both the places.
let orOutputAB = inputA | inputB

// Bitwise XOR(exclusive OR operator) operator(^): Compares the bits of two numners. Returns a new numner whose bits are set to 1 where the input bits are different and 0 when input bits are same.
let xorOutputAB = inputA ^ inputB

// Bitwise left shift(<<) operator: Move all the bits in the number to the left side by certain number of place. It has an effect of multiplying and dividing a number by 2. Shifting left doubles the value and shifting right halves the value.
let leftShiftOutputA: UInt8 = inputA << 2 // Any bit moved outside the bounds are discarded.
let rightShiftOutputB: UInt8 = inputB >> 2

let bits: UInt8 = 1
bits << 0
bits << 1
bits << 2
bits << 3
bits << 4
bits << 5
bits << 6
bits << 7

// Overflow operators:

/* Overflow addition(&+) */
var unsignedOversflowMax = UInt8.max
unsignedOversflowMax &+= 1

/* Overflow subtraction(&+) */
var unsignedOversflowMin = UInt8.min
unsignedOversflowMin &-= 1


/**
 # Operator Methods
 */

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

let vector1 = Vector2D(x: 2.0, y: 3.0)
let vector2 = Vector2D(x: 4.0, y: 9.0)
let combinedVector = vector1 + vector2

/**
 # Prefix and Postfix operators(Unary Operators)
 */

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        Vector2D(x: -vector.x, y: -vector.y)
    }
}

/**
 # Compound assignment operator
 */

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

/**
 # Equivalence Operators
 */

extension Vector2D: Equatable {}
print(vector1 != vector2)
