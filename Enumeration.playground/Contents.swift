/**
 Enumeration:
 - A common type for group of related values.
 - Enums are first class type in their own right.
 - Enum cases are defined (and typed) values in their own right.
 */

// iterable
enum Direction: CaseIterable { // conform to CaseIterable protocol
    case east
    case west
    case north
    case south
}

let directions = Direction.allCases
print("Total direction -> ", directions.count)
for direction in directions {
    print(direction)
}

/**
 Associated values
 - It allow enum cases to carry additional data.
 - This is useful when you need to store different types or pieces of information
 */

enum NetworkResponse {
    case loading
    case success(result: String)
    case failure(statusCode: Int, message: String)
}

var response: NetworkResponse = .loading
//response = .success(result: "Data successfully fetched.")
response = .failure(statusCode: 500, message: "Internal server error.")

let message: String = switch response {
case .loading:
    "Fetching..."
case .success(let result):
    result
case .failure(let statusCode, let message):
    "Error \(statusCode) - \(message)"
}

print(message)
