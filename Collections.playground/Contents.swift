
/**
 Collections
 */

let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
//print("array is an ordered collection of homogenous values: ", array)

//var set = [1, 2, 3, 4, 5, 6, 7, 8, 9] If set is initialized using array or array literal, in this case it is an ordered collection.
var set = Set<Int>()
set.insert(1)
set.insert(2)
set.insert(3)
set.insert(4)
set.insert(5)
//print("set is unordered collection of unique values: ", set)

var dict = ["one": 1, "two": 2, "three": 3]
//print("dictionary are unordered collection of key value association: ", dict)

// Array with default value
let defaultValueArray = Array(repeating: 0, count: 3)
//print("Array initialised with default 0 value and has three items in it: ", defaultValueArray)

// Adding two arrays together
let arr1 = [1, 2]
let arr2 = [3, 4, 5]
let numbers = arr1 + arr2
//print("Addition of two arrays: ", numbers)

let fromThreeToFive = numbers[2..<5]
//print("from three two five: ", fromThreeToFive)

// A value must be hashable in order to be stored in a set.
// If two values are equal, there hash value will be equal.

/**
 Sets

 - count
 - isEmpty
 - insert(_:)
 - remove(_:)
 - contains(_:)

 - intersaction(_:)
 - symmetricDifference(_:)
 - union(_:)
 - subtracting(_:)

 - isEqual
 - isSubset(of:)
 - isSuperset(of:)
 - isStrictSubset(of:)
 - isStrictSuperset(of:)
 - isDisjoint(with:)
 */

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let primeNumbers: Set = [2, 3, 7]
let all: Set = [1, 3, 5, 7, 9, 0, 2, 4, 6, 8]

/* common between two
print("intersaction of sets: ", evenDigits.intersection(oddDigits))
print("intersaction of sets: ", oddDigits.intersection(evenDigits))
print("intersaction of sets: ", evenDigits.intersection(evenDigits))
*/

/* all
print("union of sets: ", evenDigits.union(oddDigits))
print("union of sets: ", oddDigits.union(evenDigits))
print("union of sets: ", evenDigits.union(evenDigits))
print("union of sets: ", oddDigits.union(oddDigits))
*/

/* in first but not in second
print("subtraction of sets: ", evenDigits.subtracting(primeNumbers))
print("subtraction of sets: ", oddDigits.subtracting(primeNumbers))
print("subtraction of sets: ", primeNumbers.subtracting(oddDigits))
*/

/* in any of one but not in both.
print("symmetric difference of sets: ", evenDigits.symmetricDifference(oddDigits))
print("symmetric difference of sets: ", oddDigits.symmetricDifference(evenDigits))
print("symmetric difference of sets: ", evenDigits.symmetricDifference(primeNumbers))
print("symmetric difference of sets: ", oddDigits.symmetricDifference(primeNumbers))
print("symmetric difference of sets: ", primeNumbers.symmetricDifference(evenDigits))
print("symmetric difference of sets: ", primeNumbers.symmetricDifference(oddDigits))
*/

/*
print("are sets equal: ", evenDigits == oddDigits)
print("are sets equal: ", evenDigits == evenDigits)
print("**************")
print("isSubset: ", evenDigits.isSubset(of: oddDigits))
print("isSubset: ", evenDigits.isSubset(of: evenDigits))
print("isSubset: ", evenDigits.isSubset(of: all))
print("**************")
print("isSuperset: ", evenDigits.isSuperset(of: oddDigits))
print("isSuperset: ", evenDigits.isSuperset(of: evenDigits))
print("isSuperset: ", evenDigits.isSuperset(of: all))
print("isSuperset: ", all.isSuperset(of: evenDigits))
print("**************")
print("isStrictSubset: ", evenDigits.isStrictSubset(of: evenDigits)) // is subset or superset but not equal.
print("isStrictSuperset: ", evenDigits.isStrictSuperset(of: evenDigits))
print("**************")
print("isDisjoint: ", evenDigits.isDisjoint(with: oddDigits)) // two sets have no value in common.
print("isDisjoint: ", evenDigits.isDisjoint(with: primeNumbers))
print("isDisjoint: ", oddDigits.isDisjoint(with: primeNumbers))
*/

/*
 Dictionary

 - updateValue(_:forKey:)
 - removevalue(_:forKey:) */

var dict1 = ["abc": 1, "xyz": 2]
dict1["abc"] = 11
dict1["xyz"] = 22
print("dict1 :", dict1)

dict1.updateValue(1, forKey: "abc")
dict1.updateValue(2, forKey: "xyz")
print("dict1 :", dict1)

dict1.removeValue(forKey: "abc")
dict1.removeValue(forKey: "xyz")
print("dict1 :", dict1)
