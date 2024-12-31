
/**
 Control Flow
 */

for index in 0...0 { // increament will take place in the next iteration.
    print("This will execute at least once.")
}

for index in 0..<0 {
    print("This will not execute at all.")
}

/*
for index in 0...(-1) { // this will produce a crash.
    // statement
}

for index in 0..<(-1) { // this will produce a crash.
 // statement
}
 */

let numbers = ["One", "Two", "Three"]
for number in numbers { // item
    print("Number: \(number)")
}

print("************************")

for index in 0..<numbers.count { // half open range
    print("Number: \(numbers[index])")
}

print("************************")

for index in 1...5 { // close range
    print("Number: \(index)")
}

print("************************")

for (index, value) in numbers.enumerated() { // index, value tuple
    print("Number at \(index) is: \(numbers[index])")
}

print("************************")

let numDict = ["One": 1, "Two": 2, "Three": 3]
for (key, value) in numDict { // key, value
    print("numeric form of \(key) is: \(value)")
}

print("*********** stride(from:to:by) *************")

// using stride

for index in stride(from: 0, to: numbers.count, by: 1) { // This will act as a half open range and loop till the second last index.
    print("Number at \(index) is: \(numbers[index])")
}

print("*********** stride(from:through:by) *************")

for index in stride(from: 0, through: numbers.count - 1, by: 1) { // This will act as a close range and loop till the last index.
    print("Number at \(index) is: \(numbers[index])")
}

print("************************")

for index in stride(from: numbers.count - 1, through: 0, by: -1) { // loop in reverse order.
    print("Number at \(index) is: \(numbers[index])")
}

print("*********** while loop *************")

var count = 0
while(count < 10) {
    print("Value of count: \(count)")
    count += 2
}

print("*********** repeat while loop *************")

repeat {
    print("This will execute at least once.")
} while (count < 10)


print("*********** if *************")
var name: String? = "Mayank"
let greetings = if let name {
    "Hello, \(name)!"
} else {
    "Hello user"
}

print(greetings)

print("*********** if *************")

var character = "a"
let message = switch character {
case "a":
    "First character of englist alphabet."
case "z":
    "Last character of englist alphabet."
default:
    ""
}

print(message)
character = "z"
print(message) // This will again print "First character of englist alphabet.". This means it works different then computed property and can't cahnge its state.

/**
- No implicit fallthrough.
- we can use compound cases.
 */

// Interval matching
let number = 5
let matchOrNot = switch number {
case 0:
    "nothing"
case 1..<5:
    "can't match"
case 5:
    "match"
case 5..<10:
    "If case 5 is there, this will skip due to implicit fallthrough nature of switch."
case 3..<10:
    "If case 5 && 5..<10 is there, this will skip due to implicit fallthrough nature of switch."
default:
    ""
}

print(matchOrNot)

// Tuples
let coordinates = (1, 1)
let line = switch coordinates {
case (0, 0):
    print("It is a straight line at origin.")
case (0, _):
    print("It is a straight line on y-axis.")
case (_, 0):
    print("It is a straight line at x-axis.")
case (-2...2, -2...2):
    print("The line is inside the box.")
default:
    print("The line is outside the box.")
}

print(line)

print("*********** defer *************")

/**
 - it is used to execute the protion of the code when the program reaches the end of the scope.
 */

var score = 1
if score < 10 {
    defer {
        print(score)
        score = 1 // set 1 for next program.
    }
    score += 5
    print("This will execute the print statement before defer block.")
}

// Checking API availability.

if #available(iOS 15.0, *) {
    // if platform is iOS 15.0 or plus.
} else {
    // fallback.
}

@available(macOS 10.12, *)
struct ColorPreference {
    let accentColor = "blue"
}

func chooseAccentColor() -> String {
    guard #available(macOS 10.12, *) else {
        return "gray"
    }
    let colorPreference = ColorPreference()
    return colorPreference.accentColor
}

// unavailability check.
if #unavailable(iOS 15.0) {
    // fallback code.
}
