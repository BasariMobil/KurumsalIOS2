//
//  Favorites.swift
//  MoviesCatalog
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation
import RealmSwift

class Favorites: Object {
    
    @objc dynamic var rank = Int()
    @objc dynamic var id = Int64()
    @objc dynamic var title = String()
    @objc dynamic var overview = String()
    @objc dynamic var posterPath = String()
    @objc dynamic var releaseDate = Date()
    @objc dynamic var vote_average = String()
    
}
