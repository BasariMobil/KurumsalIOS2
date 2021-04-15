//
//  MoviesResponse.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

enum MoviesResponse {
    case success(movies: [Movie])
    case failed(error: ApiErrorType)
    static func parse(_ jsonData: Data) -> MoviesResponse {
        guard let results = MoviesResults(data: jsonData) else {
            debugPrint("💥 DECODING ERROR: MoviesResults")
            return .failed(error: .parseError)
        }
        return .success(movies: results.movies)
    }
}
