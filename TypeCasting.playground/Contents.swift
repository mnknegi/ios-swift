
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
] // type of library inferred to be [MovieItem]

/* Type Checking */
// `is`: Type check operator. Check whether the type of the instance is of certain subclass

for item in library {
    if item is Movie {
        print("\(item.name) is a movie.") // we can't access item.director as item is of MediaItem type.
    } else if item is Song {
        print("\(item.name) is a song.")
    }
}

/* Downcasting */

for item in library {
    if let movie = item as? Movie {
        print("\(movie.name) is a movie directed by \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name) by \(song.artist)")
    }
}

import Foundation

/* upcasting*/
let movie = Movie(name: "Casablanca", director: "Michael Curtiz")
let mediaItem = movie as MediaItem

let string: NSString = "Hello, World!"
let swiftString: String = string as String
