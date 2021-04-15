//
//  TabBarViewController.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import UIKit

enum TabBarItem {
    case discover, favorites, search, watchlist

    var title: String {
        switch self {
        case .discover  : return "Discover"
        case .favorites : return "Favorites"
        case .search    : return "Search"
        case .watchlist : return "Watchlist"
        }
    }
}

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }

    private func configureTabBar() {
        let discoverNavController = UINavigationController(rootViewController: DiscoverTableVC())
        let favoritesNavController = UINavigationController(rootViewController: FavoritesDetailsVC())
        let searchNavController = UINavigationController(rootViewController: SearchTableVC())
        let watchlistNavController = UINavigationController(rootViewController: WatchlistVC())

        discoverNavController.tabBarItem = UITabBarItem(title: TabBarItem.discover.title,
                                                        image: Image.by(assetId: .tabBarDiscoverNormal),
                                                        selectedImage: Image.by(assetId: .tabBarDiscoverSelected))

        favoritesNavController.tabBarItem = UITabBarItem(title: TabBarItem.favorites.title,
                                                         image: Image.by(assetId: .tabBarFavoritesNormal),
                                                         selectedImage: Image.by(assetId: .tabBarFavoritesSelected))

        searchNavController.tabBarItem = UITabBarItem(title: TabBarItem.search.title,
                                                      image: Image.by(assetId: .tabBarSearchNormal),
                                                      selectedImage: Image.by(assetId: .tabBarSearchSelected))
        
        watchlistNavController.tabBarItem = UITabBarItem(title: "Watchlist",
                                                         image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))

        viewControllers = [discoverNavController,searchNavController, favoritesNavController, watchlistNavController]
    }
}
