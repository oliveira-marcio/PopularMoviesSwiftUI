import SwiftUI

struct ContentView: View {
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
                    HStack {
                        NetworkImage(urlString: movie.posterPath)
                        Text(movie.title)
                            .bold()
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
        ContentView(viewModel: MovieViewModel(movies: movies))
    }
}

struct NetworkImage: View {
    let urlString: String

    @StateObject var viewModel: NetworkViewModel

    init(urlString: String) {
        self.urlString = urlString
        self._viewModel = StateObject(wrappedValue: NetworkViewModel())
    }

    var body: some View {
        if let imageData = viewModel.imageData,
            let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 75)
        } else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 75)
                .background(Color.gray)
                .onAppear() {
                    viewModel.fetchPoster(from: urlString)
                }
        }
    }
}
