//
//  AppError.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

protocol AppError: Error {
    var description: String { get }
}

enum ApplicationError: AppError {
    case commonError, noResultsError, apiError(type: ApiErrorType)

    var description: String {
        switch self {
        case .commonError            : return "Common error"
        case .noResultsError         : return "No results"
        case .apiError(let apiError) : return apiError.description
        }
    }
}

enum ApiErrorType: AppError {
    case commonError, serverError, parseError, responseError

    var description: String {
        switch self {
        case .commonError   : return "Common API error"
        case .parseError    : return "Parse Error"
        case .responseError : return "Response Error"
        case .serverError   : return "Server Error"
        }
    }
}

