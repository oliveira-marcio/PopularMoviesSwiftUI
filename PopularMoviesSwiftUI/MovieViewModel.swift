import Foundation
import SwiftUI

struct Movie: Hashable, Codable {
    var title: String
}

class MovieViewModel: ObservableObject {
    @Published var movies = [Movie]()

    init() {
        fetchMovies()
    }

    private func fetchMovies() {
        let jsonData = """
        [
            { "title": "Matrix" },
            { "title": "Avengers" },
            { "title": "Lord of the Rings" },
            { "title": "Hancock" }
        ]
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        if let movies = try? decoder.decode([Movie].self, from: jsonData) {
            self.movies = movies
        }
    }
}
