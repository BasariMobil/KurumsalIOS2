//
//  WatchlistVC.swift
//  MoviesCatalog
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import UIKit
import RealmSwift
import SDWebImage

final class WatchlistVC: UIViewController {
    
    let tableView = UITableView()
    var movie : [Watchlist] = []
    
    struct Cells {
        static let watchlistCell = "WatchlistCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Watchlist"
        tableView.delegate = self
        tableView.dataSource = self
        subviews()
        constraints()
        setupTableView()
        self.movie = self.getWatchList()
        self.tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationWatchList), name: .notificationMovieWatchlist, object: nil)
        
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WatchListItemCell.self, forCellReuseIdentifier: Cells.watchlistCell)
    }
    
    func getWatchList() -> [Watchlist] {
        
        var objects = [Watchlist]()
        
        for object in mRealm.objects(Watchlist.self).sorted(byKeyPath: "rank", ascending: false){
            
            objects.append(object)
        }
        
        return objects
    }
    
    @objc func notificationWatchList() {
        
        self.movie = self.getWatchList()
        self.tableView.reloadData()
    }
    
    
}

extension WatchlistVC {
    func subviews() {
        view.addSubview(tableView)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension WatchlistVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.watchlistCell, for: indexPath) as! WatchListItemCell
        let watchMovie = movie[indexPath.row]
        
        cell.set(watchlist: watchMovie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = MovieDeatilsVC(movieId:movie[indexPath.row].id)
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
