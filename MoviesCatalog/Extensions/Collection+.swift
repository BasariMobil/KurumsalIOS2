//
//  Collection+.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation

extension Collection {

    subscript(safe index: Index) -> Iterator.Element? {
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }
}
