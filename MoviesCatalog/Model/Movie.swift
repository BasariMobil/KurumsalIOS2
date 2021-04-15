//
//  Movie.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

struct Movie: Equatable {

    let id: Int64?
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: Date?
    let vote_average : Double?
}

extension Movie: Decodable {

    enum CodingKeys: String, CodingKey {
        case id, title, overview, vote_average
        case posterPath  = "poster_path"
        case releaseDate = "release_date"
    }

    init?(data: Data) {
        guard let me = try? JSONDecoder.theMovieDB.decode(Movie.self, from: data) else { return nil }
        self = me
    }
}
