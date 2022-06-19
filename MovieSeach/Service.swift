//
//  Service.swift
//  MovieSeach
//
//  Created by Francis Adelante on 6/17/22.
//

import Foundation

//customize network error
enum NetworkError:Error {
    case badURL
    case badID
}
class Service: NSObject {

    func getMovies(searchTerm: String) async throws -> [Movie] {
       
        //setting up url components
        var components = URLComponents()
        components.scheme = "http"
        components.host = "omdbapi.com"
        components.queryItems = [
            URLQueryItem(name: "s", value: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)),
            URLQueryItem(name: "apiKey", value: "8acc4f40")
        ]
        
        //checking url
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        print(url)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        //checking success response
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badID
        }
        
        //decoding response
        let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse?.movies ?? []
    }
}
