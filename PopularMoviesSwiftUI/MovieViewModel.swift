import Foundation
import SwiftUI

struct Movie: Hashable {
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String

    init(title: String,
         overview: String,
         posterPath: String,
         releaseDate: String) {
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
}

@MainActor class MovieViewModel: ObservableObject {
    @Published var movies: [Movie]

    init() {
        movies = []
    }

    init(movies: [Movie]) {
        self.movies = movies
    }

    func getMovies() async {
        guard movies.isEmpty,
              let movies = try? await Repository.shared.fetchMovies()
        else { return }
        self.movies = movies
    }
}
