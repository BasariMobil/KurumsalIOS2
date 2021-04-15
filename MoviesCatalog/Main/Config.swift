//
//  Config.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

struct Config {

    static let apiKey = "6c52966d9be717e486a2a0c499867009"
    
    static let maxQueriesHistoryCount = 10

    struct URL {
        static let base = "http://api.themoviedb.org/3"
        static let basePoster = "http://image.tmdb.org/t/p"
    }
    
    struct Keys {
        static let queriesHistory = "_queriesHistory"
    }
    
    struct CellIdentifier {
        struct MovieTable {
            static let movieCell = "MovieItemCell"
            static let historyCell = "HistoryItemCell"
        }
    }
}
