//
//  MovieListViewModel.swift
//  MovieSeach
//
//  Created by Francis Adelante on 6/17/22.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    
    @Published var movies:[MovieViewModel] = []
    
    func search(name: String) async {
        
        do {
            let movies = try await Service().getMovies(searchTerm: name)
            self.movies = movies.map(MovieViewModel.init)
        } catch {
            print(error)
        }
        
    }
    
}

struct MovieViewModel {
   
    let movie:Movie
   
    var imdbId: String {
        movie.imdbId
    }
    
    var title: String {
        movie.title
    }
   
    var poster: String {
        movie.poster
    }
  
    var year: String {
        movie.year
    }
     
    var type:String {
        movie.type
    }
}
