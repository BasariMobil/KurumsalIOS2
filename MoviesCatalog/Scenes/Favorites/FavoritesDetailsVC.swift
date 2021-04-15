
//  FavoritesDetailsVC.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//



import UIKit
import RealmSwift
import SDWebImage

class FavoritesDetailsVC : UIViewController {
    
    let tableView = UITableView()
    var movie : [Favorites] = []
    
    struct Cells {
        static let favoritesCell = "FavoritesCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorites"
        tableView.delegate = self
        tableView.dataSource = self
        subviews()
        constraints()
        setupTableView()
        self.movie = self.getFavorites()
        self.tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationFavorites), name: .notificationMovieFavorites, object: nil)
        
    }
    
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoritesItemCell.self, forCellReuseIdentifier: Cells.favoritesCell)
    }
    
    func getFavorites() -> [Favorites] {
        
        var objects = [Favorites]()
        
        for object in mRealm.objects(Favorites.self).sorted(byKeyPath: "rank", ascending: false){
            
            objects.append(object)
        }
        
        return objects
    }
    
    @objc func notificationFavorites() {
        
        self.movie = self.getFavorites()
        self.tableView.reloadData()
    }
    func movieItem(at indexPath: IndexPath) -> Favorites? {
        return movie[safe: indexPath.row]
    }
    
}

extension FavoritesDetailsVC {
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

extension FavoritesDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.favoritesCell, for: indexPath) as! FavoritesItemCell
        let favMovie = movie[indexPath.row]
        
        cell.set(favorite: favMovie)
        
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
