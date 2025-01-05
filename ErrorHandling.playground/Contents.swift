
/* Error handling */
// Process of responding to and recovering from error condition in your program.

enum NetworkError: Error {
    case badURL
    case internalServerError(statusCode: Int, message: String)
    case networkError(message: String)
}

func functionCanThrowErrors() throws -> String {
    throw NetworkError.badURL
}


// Example

import Foundation

struct User: Decodable {
    let name: String
    let age: Int
}

final class Service {

    func getUsers<T: Decodable>(url: String) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: URL(string: url)!))
        let user = try JSONDecoder().decode(T.self, from: data)
        return user
    }
}

final class ViewModel {

    let service = Service()

    func getAllUsers() async {
        do {
            let users: [User] = try await service.getUsers(url: "https://example.com")
        } catch NetworkError.badURL {
            print("Please check your URL.")
        } catch NetworkError.internalServerError(let statusCode, let message) {
            print("Error; \(statusCode) - \(message)")
        } catch NetworkError.networkError(let message) {
            print("Error: \(message)")
        } catch {
            print("Something went wrong...")
        }
    }

    /* Typed Throws Swift 6.0*/
    /*
    func funcThatThrowsNetworkErrorOnly() throws(NetworkError) {
        throw NetworkError.badURL
    }
     */
}
