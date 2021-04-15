//
//  MoviesResults.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

struct MoviesResults {
    
    let movies: [Movie]
}

extension MoviesResults: Decodable {

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }

    init?(data: Data) {
        guard let me = try? JSONDecoder.theMovieDB.decode(MoviesResults.self, from: data) else { return nil }
        self = me
    }
}
