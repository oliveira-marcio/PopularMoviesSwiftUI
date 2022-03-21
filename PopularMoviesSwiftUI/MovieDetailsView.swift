import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
//        UITableView.appearance().backgroundColor = .systemBackground
    }

    var body: some View {
        ScrollView {
            VStack {
                NetworkImage(urlString: movie.posterPath,
                             width: 200,
                             height: 300)
                .padding(3)
                Text(movie.title)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(3)
                Text(movie.overview)
                    .padding(3)
                Text("Released: \(movie.releaseDate)")
                Spacer()
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static let movie = Movie(title: "Matrix",
                             overview: "Nice movie about people killing each other in a fake world",
                             posterPath: "foo.com",
                             releaseDate: "1/1/1999")

    static var previews: some View {
        MovieDetailsView(movie: movie)
    }
}
