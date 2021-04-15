//
//  TheMovieDBApi.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

import RxSwift

final class TheMovieDBApi {

    let manager: APIManager

    init(manager: APIManager) {
        self.manager = manager
    }
    func searchMovies(_ endpoint: TheMovieDBEndpoint) -> Observable<MoviesResponse> {
        return manager.request(for: endpoint)
            .debug()
            .map(MoviesResponse.parse)
    }
    func discoverPopularMovies(_ endpoint: TheMovieDBEndpoint) -> Observable<MoviesResponse> {
        return manager.request(for: endpoint)
            .debug()
            .map(MoviesResponse.parse)
    }

    func getMovieDetails(_ endpoint: TheMovieDBEndpoint) -> Observable<MovieDetailsResponse> {
        return manager.request(for: endpoint)
            .debug()
            .map(MovieDetailsResponse.parse)
    }
}
