//
//  MovieDetailsResponse.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

enum MovieDetailsResponse {
    case success(movie: Movie)
    case failed(error: ApiErrorType)

    static func parse(_ jsonData: Data) -> MovieDetailsResponse {
        guard let movie = Movie(data: jsonData) else {
            debugPrint("💥 DECODING ERROR: Movie")
            return .failed(error: .parseError)
        }
        return .success(movie: movie)
    }
}
