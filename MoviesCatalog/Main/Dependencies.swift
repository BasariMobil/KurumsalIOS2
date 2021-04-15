//
//  Dependencies.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

final class Dependencies {

    static let shared = Dependencies()

    var api: TheMovieDBApi

    init() {
        let apiManager = APIManager(session: URLSession(configuration: .default))
        self.api = TheMovieDBApi(manager: apiManager)
    }
}
