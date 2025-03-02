
/*
 # Concurrency - Perform asynchronous operations.
 */

import Foundation

func listPhotos(inGallery: String, completion: @escaping ([String]) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        // Some Network Code
        completion(["John", "Mary", "Steven"])
    }
}

func downloadPhoto(named: String, completion: @escaping (String) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        // Some Network Code
        completion("John")
    }
}

func show(_ photo: String) {
    // update photo
}

listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}

// Here series of completion handlers create complex nested closures. This will quickly become unwieldy.

/*
 ## Defining and calling asynchronous fucntion.

 - An Asynchronous function or Asynchronous method is a special kind of function or method that can be suspended during execution.
 - It can pause in the middle when it is waiting for something.
 - Inside asynchronous function or method, we can mark each places where execution can be suspended.
 - The possible suspension point will marked with await indicating that a current piece of code might pause execution while waiting for the asynchronous function or method to return.
 - `Yielding of thread`: Swift suspends the execution of our code on current thread and run some other code on that thread instead.
 */

func listPhotos(inGallery: String) async -> [String] {
    // Some long running task.
    return ["John", "Mary", "Steven"]
}

func downloadPhoto(named: String) async -> String {
    // Some long running task.
    print("Start photo downloading...")
    try? await Task.sleep(for: .seconds(5))
    print("photo downloaded")
    return named
}

/*
 ## Calling asynchronous code

 - From the body of asynchronous function, method or property.
 - From the static main method marked with @main of a class, structure or enumeration.
 - From the unstructured child task.
 */

func generateSlideShow(forGallery gallery: String) async {
    let photos = await listPhotos(inGallery: gallery)
    let sortedNames = photos.sorted()
    let downloadedPhoto = await downloadPhoto(named: sortedNames[0])
    show(downloadedPhoto)
}

/*
 - We can explicitly insert a suspention point by calling Task.yield() method.
 */

func performHeavyTask() async {
    for i in 0..<25 {
        print("Performing step \(i)")
        await Task.yield()
    }
}

Task {
    await performHeavyTask()
    print("Heavy task finished!")
}

Task {
    print("Another task is running!")
}

/*
 ## Sequence(in Swift)

 - It represents a series of values that can be iterated over one-by-one.
 - A Swift sequence is a list of values that we can iterate over(step through one at a time (as in for-in loop)).
 - They can be used to create custom collection types.
 - To make our custom type which we can iterate over, we need to conform the type with two protocols: `Sequence` and `IteratorProtocol`.
 - Sequence describes something that can be looped over, and iteratorProtocol describes something that iterates over a sequence.
 - We need to implement next() returning whatever value comes next in your sequence.
 */

// build-in sequence

let numbers = [1, 2, 3, 4, 5]

for number in numbers {
    // do something.
}

// custom sequence
struct Countdown: Sequence {
    let start: Int

    func makeIterator() -> CountdownIterator {
        CountdownIterator(self)
    }
}

struct CountdownIterator: IteratorProtocol {
    
    var countdown: Countdown
    var current: Int

    init(_ countdown: Countdown) {
        self.countdown = countdown
        self.current = countdown.start
    }

    mutating func next() -> Int? {
        /*
        if current > 0 {
            defer { current -= 1 }
            return current
        } else {
            return nil
        }
*/
        while(current != 0) {
            defer { current -= 1 }
            return current
        }
        return nil
    }
}

let countdown = Countdown(start: 5)
for number in countdown {
//    print(number)
}

/*
 ## Asynchronous Sequence(work with a sequence of values that are delivered over time.)

 - listPhotos(inGallery:) returns whole array once the async execution returns.
 - If we want to wait only for one element of the collection at a time, we can do this using asynchronous sequence.
 - A for-await-in loop creates a possible suspends execution at the beginning of each iteration, when it's waiting for the next element to be available.
 - For this we need our type to conform to AsyncSequence
 */

// build-in AsyncSequence(AsyncStream)
func fetchNumber() -> AsyncStream<Int> {
    AsyncStream { continuation in
        Task {
            for index in 1...5 {
                continuation.yield(index) // send the value asynchronously.
                try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
            }
            continuation.finish() // indicate the stream is done.
        }
    }
}

/*
Task {
    for await number in fetchNumber() {
        print("Received : \(number)")
    }
    print("stream finished!")
}
*/

// Custom sequence
struct Countdown2: AsyncSequence {
    
    typealias Element = Int

    let start: Int

    func makeAsyncIterator() -> Countdown2Iterator {
        Countdown2Iterator(self)
    }

    struct Countdown2Iterator: AsyncIteratorProtocol {

        var countdown: Countdown2
        var current: Int

        init(_ countdown: Countdown2) {
            self.countdown = countdown
            self.current = countdown.start
        }

        mutating func next() async -> Int? {
            while(current != 0) {
                defer { current -= 1 }
                try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                return current
            }
            return nil
        }
    }
}

Task {
    let countdown2 = Countdown2(start: 5)
    for await number in countdown2 {
        print("Received async number seq: \(number)")
    }
    print("countdown finished!")
}

/*
 ## Calling Asynchronous functions in parallel

 - Calling asynchronous func with await run only one piece of code at a time.
 - While the async code is running the called wait for the code to finish before moving to the next line.
 - To call the asynchronous func and let it run in parallel with other asynchronous tasks, write async infront of let when you define a constant and use await everytime when use that constant.
 */

func downloadDocument() async -> String {
    print("Start document downloading...")
    try? await Task.sleep(for: .seconds(1))
    print("Document downloaded")
    return "Document fetch completed."
}

/* Serial execution */

//Task {
//    let firstPhoto = await downloadPhoto(named: "John")
//    let secondPhoto = await downloadPhoto(named: "Mary")
//    let thirdPhoto = await downloadPhoto(named: "Steven")
//
//    let photos = [firstPhoto, secondPhoto, thirdPhoto]
//    for photo in photos {
//        print("fetched serially: ", photo)
//    }
//}

/* Concurrent/Parallel execution */

Task {
    async let photo = downloadPhoto(named: "John")
    async let document = downloadDocument()

    let files = await [photo, document] // constant is used with await
    for file in files {
        print("fetch parallelly: ", file)
    }
}


/*
 ## Tasks and Task Groups

 - Task is the unit of work that can run asynchronously as part of our programme. All asynchronous code run as a part of some task.
 - async-let syntax implicitely creates a child task.
 - We can also create a task group and explicitely add child task into task group dynamically.
 - Each task in a given task group have a same parent task, and each task can have child tasks.
 - Because of this explicit relationship between task and task group, this approach is called `structured concurrency`.

 parent-child relationship has below advantages:
 - In a parent task, you can't forgot to wait for the child tasks to complete.
 - When setting a higher priority to a child task, the parent task's priority automatically escalated.
 - When a parent task is cancelled, all of its child tasks also automatically cancelled.
 - Task local values propagated to child tasks efficiently and automatically.
 */

Task {
    let photos = await withTaskGroup(of: String.self) { group in
        let photoNames = await listPhotos(inGallery: "Summer vacations")
        for name in photoNames {
            group.addTask {
                return await downloadPhoto(named: name)
            }
        }

        var result: [String] = []
        for await photo in group {
            result.append(photo)
        }

        return result
    }
}


/*
 ## Task Cancellation

 - We can check task cancellation by Task.checkCancellation() type method or Task.isCancelled type property.
 - Task.checkCancelled() throws an error if the task is cancelled and the error can propagate out of the task, stopping all the task's work.
 - Task.isCancelled let us do the cleanup work as a part of stopping the task.
 */

Task {
    let photos = await withTaskGroup(of: Optional<String>.self) { group in
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        for photoName in photoNames {
            let added = group.addTaskUnlessCancelled { // add the task if it is not cancelled.
                guard !Task.isCancelled else { return nil } // chech whether the task is cancelled or not, if yes return nil else start downloading photo.
                return await downloadPhoto(named: photoName)
            }
            guard added else { break } // check whether the task is successfully added if it is cancelled break out of loop.
        }

        var result: [String] = []
        for await photo in group {
            if let photo { result.append(photo) }
        }
        return result
    }
}


/*
 ## Unstructured Concurrency

 - Unlike tasks that are the part of task group, an unstructured task doesn't have a parent task.
 - It give devs complete flexibility to manage unstructured tasks in whatever way we the program needs.
 - Task.init(priority:operation:)
 - Task.detached(priority:operation:)
 */


/*
## Actors

 - Task breaks the program into isolated, concurrent pieces.
 - Tasks are isolated from each other which makes them safe to run at the same time, but sometimes we need to share some information between tasks.
 - Actors let us safely share information between concurrent code.

 - Like classes, actors are also reference type.
 - Unlike classes, actors only let one task access their mutable state at a time. Which makes it safe to interact with the same instance of the actor with the multimple tasks.

 - While accessing the actor property, we need to mark it with `await` keyword to create a suspention point. This let the other task to wait for the first task to access the actor property.
 - If we try to access actor's property inside from the same actor, in this case we don't have to write `await` keyword before it.
 */

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement // The TemperatureLogger is in a temporary inconsistent state. Actor prevent multiple task to interact with same instance simultaneously which prevents any race condition here.
        }
    }
}

/*
 - The code to access the max property needs to run as a part of an actor, which is an asynchronous operation an requires writing await.
 - Swift guarantees that only code running as a part of actor can access the actor's local state, that is called - actor isolation.
 */


/*
 ## Sendable Types

 - `Concurrency Domain` - A concurrency domain is a region of exexution where code runs without data race.
 - Different concurrency domains can run independently(separate tasks, actors, threads).
 - Swift sendable protocol ensures that data passed between domains is safe to share.

 Common Concurrency Domains in Swift:
- Main Actor (@MainActor) – Manages code execution on the main thread.
- Actors – Provide isolated mutable state per instance.
- Tasks – Represent units of asynchronous work (Task { ... }).
- Global Executors – Default Swift executor for running tasks concurrently.
 */

// Unsafe example
class Counter {
    var value: Int = 0
}

let counter = Counter()

Task {
    counter.value += 1  // Task 1: Concurrency Domain 1. Risky shared mutable state.
}

Task {
    counter.value += 1  // Task 2: Concurrency Domain 2 Risky shared mutable state.
}

// safe example using actor
actor Counter2 {
    private var value: Int = 0

    func increment() {
        value += 1
    }

    func decrement() {
        value -= 1
    }

    func getValue() -> Int {
        value
    }
}

let counter2 = Counter2()
await counter2.increment()
print(await counter2.getValue())

// Sendable endures that values can be safely transferred between concurrency domains.
// Actors are inherently sendable since they are designed to isolate state.
// `@unchecked Sendable` tells the compiler, "Trust me, this type is safe across concurrency boundaries."


// Sendable example
struct User: Sendable {
    let id: Int
    let name: String
}

let user = User(id: 1, name: "User")

Task {
    print(user.name)
}
