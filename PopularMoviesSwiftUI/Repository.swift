import Foundation

struct MoviesEntity: Decodable {
    let results: [MovieEntity]
}

struct MovieEntity: Decodable {
    var title: String
    var overview: String
    var posterPath: String
    var releaseDate: String
}

extension Movie {
    init(from entity: MovieEntity) {
        self.init(title: entity.title,
                  overview: entity.overview,
                  posterPath: "https://image.tmdb.org/t/p/w500\(entity.posterPath)",
                  releaseDate: entity.releaseDate)
    }
}

class Repository {
    static var shared: Repository {
        Repository()
    }

    private init() {}

    func fetchMovies() async throws -> [Movie] {
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(getApiKey())&page=1")!)
        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        let movies = try decoder.decode(MoviesEntity.self, from: data)
        return movies.results.map { Movie(from: $0) }
    }

    func fetchPoster(from urlString: String) async throws -> Data {
        let request = URLRequest(url: URL(string: urlString)!)
        return try await URLSession.shared.data(for: request).0
    }

    private func getApiKey() -> String {
        guard let dict = Bundle.main.infoDictionary, let apiKey = dict["movies_api_key"] as? String else {
            fatalError("Configuration Plist file not found.")
        }

        return apiKey
    }
}
