//
//  ContentView.swift
//  MovieSeach
//
//  Created by Francis Adelante on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var movieListViewModel = MovieListViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            List(movieListViewModel.movies, id: \.imdbId){ movie in
                HStack(alignment: .center, spacing: 20, content: {
                    AsyncImage(url: URL(string: movie.poster)) { img in
                        img.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100)
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .leading, content: {
                        Text(movie.title)
                            .bold()
                        Text("Type: \(movie.type)")
                           
                        Text("Year: \(movie.year)")
                    })
                })
            }.listStyle(.plain)
                .searchable(text: $searchText)
                .onChange(of: searchText) { newValue in
                    Task {
                        if !newValue.isEmpty && newValue.count > 3 {
                            await movieListViewModel.search(name: newValue)
                        } else {
                            movieListViewModel.movies.removeAll()
                        }
                    }
                }
                .navigationTitle("Movies")
                .font(.system(size: 13, weight: .bold, design: .serif))
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
