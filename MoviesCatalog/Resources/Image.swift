//
//  Image.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import UIKit

struct Image {
    
    static func by(assetId: ImageAssetId) -> UIImage? {
        return UIImage(named: assetId.rawValue)
    }
}

enum ImageAssetId: String, CaseIterable {

    case tabBarDiscoverNormal, tabBarFavoritesNormal, tabBarSearchNormal
    case tabBarDiscoverSelected, tabBarFavoritesSelected, tabBarSearchSelected

    case disclosureIndicator, iconReleaseFrame
}
