import SwiftUI

struct MoviesListView: View {
    @StateObject var viewModel: MovieViewModel

    init() {
        self._viewModel = StateObject(wrappedValue: MovieViewModel())
    }

    init(viewModel: MovieViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        UITableView.appearance().backgroundColor = .systemBackground
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies, id:\.self) { movie in
                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                        HStack {
                            NetworkImage(urlString: movie.posterPath,
                                         width: 50,
                                         height: 75)
                            Text(movie.title)
                                .bold()
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Movies")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var movies = [
        Movie(title: "Matrix",
              overview: "",
              posterPath: "foo.com",
              releaseDate: ""),
        Movie(title: "Lord of the Rings",
              overview: "",
              posterPath: "foo.com",
              releaseDate: ""),
        Movie(title: "Avengers",
              overview: "",
              posterPath: "foo.com",
              releaseDate: ""),
    ]

    static var previews: some View {
        MoviesListView(viewModel: MovieViewModel(movies: movies))
    }
}
