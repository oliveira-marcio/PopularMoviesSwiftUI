//
//  ContentView.swift
//  PopularMoviesSwiftUI
//
//  Created by Márcio Oliveira on 20/03/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: MovieViewModel

    init() {
        self._viewModel = StateObject(wrappedValue: MovieViewModel())
    }

    init(viewModel: MovieViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies, id:\.self) { movie in
                    Text(movie.title)
                        .padding()
                }
            }
            .navigationTitle("Movies")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var movies = [
        Movie(title: "Matrix",
              overview: "",
              posterPath: "",
              releaseDate: ""),
        Movie(title: "Lord of the Rings",
              overview: "",
              posterPath: "",
              releaseDate: ""),
        Movie(title: "Avengers",
              overview: "",
              posterPath: "",
              releaseDate: ""),
    ]

    static var previews: some View {
        ContentView(viewModel: MovieViewModel(movies: movies))
    }
}
