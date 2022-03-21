//
//  ContentView.swift
//  PopularMoviesSwiftUI
//
//  Created by Márcio Oliveira on 20/03/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieViewModel()

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
    static var previews: some View {
        ContentView(viewModel: MovieViewModel())
    }
}
