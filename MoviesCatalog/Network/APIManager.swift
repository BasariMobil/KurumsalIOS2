//
//  APIManager.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

import RxCocoa
import RxSwift

protocol NetworkingManager {
    func request(for: Endpoint) -> Observable<Data>
}

final class APIManager: NetworkingManager {

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request(for endpoint: Endpoint) -> Observable<Data> {
        guard let escString = endpoint.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: escString) else {
                return Observable.error(ApplicationError.apiError(type: .commonError))
        }

        let request = createRequest(from: url)

        return URLSession.shared.rx
            .response(request: request)
            .flatMap(handleResponse)
    }

    private func createRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringCacheData
        return request
    }

    private func handleResponse(response: HTTPURLResponse, data: Data) throws -> Observable<Data> {
        if 200 ..< 300 ~= response.statusCode {
            return Observable.just(data)
        } else {
            throw ApplicationError.apiError(type: .responseError)
        }
    }
}
