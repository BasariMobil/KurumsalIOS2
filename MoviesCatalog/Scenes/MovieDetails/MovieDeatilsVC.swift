//
//  MovieDeatilsVC.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import UIKit

import Kingfisher
import RxSwift
import RealmSwift

final class MovieDeatilsVC: BaseVC {
    
    private var model: MovieDetailsVM!
    
    private let scrollView = UIScrollView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.add(subviews: posterImageView, movieTitleLabel, movieOverviewLabel, releaseDateView, movieVoteLabel)
        return view
    }()
    
    var setDBMovieId = Int64()
    var movieDate = Date()
    var movieId = Int64()
    var movieVote = ""
    var dbposterPath = ""
    var movieOverview = ""
    var movieTitle = ""
    private let posterImageView = UIImageView(contentMode: .scaleAspectFill)
    private let movieTitleLabel = UILabel(font: .systemFont(ofSize: 25, weight: .semibold), lines: 1)
    private let movieOverviewLabel = UILabel(font: .systemFont(ofSize: 16, weight: .light))
    private let movieVoteLabel = UILabel(font: .systemFont(ofSize: 16, weight: .semibold))
    private let releaseDateView = MovieYearReleaseView()
    
    init(movieId: Int64) {
        model = MovieDetailsVM(movieId: movieId)
        setDBMovieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setDBMovieId = Int64()
    }
    
    override func setupViewAndConstraints() {
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        navigationButtosConfig()
        
        if #available(iOS 11.0, *) {
            scrollView.mrk.top(to: view.safeAreaLayoutGuide)
            scrollView.mrk.bottom(to: view.safeAreaLayoutGuide)
        } else {
            scrollView.mrk.top(to: view)
            scrollView.mrk.bottom(to: view)
        }
        scrollView.mrk.leading(to: view)
        scrollView.mrk.trailing(to: view)
        
        containerView.mrk.top(to: scrollView)
        containerView.mrk.bottom(to: scrollView)
        
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        
        posterImageView.mrk.top(to: containerView)
        posterImageView.mrk.leading(to: containerView)
        posterImageView.mrk.trailing(to: containerView)
        posterImageView.mrk.height(650)
        
        movieTitleLabel.mrk.top(to: posterImageView, attribute: .bottom, relation: .equal, constant: 8.5)
        movieTitleLabel.mrk.leading(to: containerView, attribute: .leading, relation: .equal, constant: 13)
        movieTitleLabel.mrk.trailing(to: containerView, attribute: .trailing, relation: .equal, constant: -13)
        
        movieOverviewLabel.mrk.top(to: movieTitleLabel, attribute: .bottom, relation: .equal, constant: 5)
        movieOverviewLabel.mrk.leading(to: movieTitleLabel)
        movieOverviewLabel.mrk.trailing(to: movieTitleLabel)
        
        releaseDateView.mrk.top(to: movieOverviewLabel, attribute: .bottom, relation: .equal, constant: 12)
        releaseDateView.mrk.leading(to: containerView, attribute: .leading, relation: .equal, constant: 13)
        releaseDateView.mrk.bottom(to: containerView, attribute: .bottom, relation: .equal, constant: -12)
        
        
        movieVoteLabel.mrk.top(to: movieOverviewLabel, attribute: .bottom, relation: .equal, constant: 12)
        movieVoteLabel.mrk.leading(to: containerView, attribute: .leading, relation: .equal, constant: 303)
        movieVoteLabel.mrk.bottom(to: containerView, attribute: .bottom, relation: .equal, constant: -12)
        
        
    }
    
    override func bind() {
        model.inProgress
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        model.movieData
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] movie in
                guard let `self` = self else { return }
                
                self.title = movie.title
                
                if let path = movie.posterPath, let imageBaseUrl = URL(string: Config.URL.basePoster) {
                    let posterPath = imageBaseUrl
                        .appendingPathComponent("w780")
                        .appendingPathComponent(path)
                    
                    self.dbposterPath = "\(posterPath)"
                    
                    self.posterImageView.kf.indicatorType = .activity
                    self.posterImageView.kf.setImage(
                        with: posterPath,
                        options: [.transition(.fade(0.2))]
                    )
                }
                self.movieId = movie.id!
                self.movieDate = movie.releaseDate!
                self.movieVote = String(movie.vote_average!)
                self.movieTitle = movie.title!
                self.movieOverview = movie.overview!
                
                
                
                self.movieVoteLabel.text = "⭐️  " + String(movie.vote_average!)
                self.movieTitleLabel.text = movie.title
                self.movieOverviewLabel.text = movie.overview
                
                self.releaseDateView.setupWith(date: movie.releaseDate)
            }).disposed(by: disposeBag)
        
        
    }
    
    func navigationButtosConfig() {
        
        var listImage = UIImage()
        var favImage = UIImage()
        
        let favObject = mRealm.objects(Favorites.self).filter("id == %@", setDBMovieId)
        let listObject = mRealm.objects(Watchlist.self).filter("id == %@", setDBMovieId)
        
        if favObject.count <= 0 {
            favImage = UIImage(systemName: "suit.heart")!
            
        } else {
            favImage = UIImage(systemName: "suit.heart.fill")!
            
        }
        
        if listObject.count <= 0 {
            listImage = UIImage(systemName: "text.badge.plus")!
            
        } else {
            listImage = UIImage(systemName: "text.badge.minus")!
            
        }
        
        let favButton = UIBarButtonItem(image: favImage,  style: .plain, target: self, action: #selector(didTapFavButton(sender:)))
        let listButton   = UIBarButtonItem(image: listImage,  style: .plain, target: self, action: #selector(didTapListButton(sender:)))
        
        
        
        navigationItem.rightBarButtonItems = [listButton, favButton]
        
    }
    
    @objc func didTapListButton(sender: AnyObject){
        
        let movie = Watchlist()
        movie.rank = getAuntoIncIntId()
        movie.id = movieId
        movie.overview = movieOverview
        movie.title = movieTitle
        movie.releaseDate = movieDate
        movie.vote_average = movieVote
        movie.posterPath = dbposterPath
        
        let object = mRealm.objects(Watchlist.self).filter("id == %@", movie.id)
        if object.count <= 0 {
            try! mRealm.write {
                mRealm.add(movie)
            }
        }else {
            try! mRealm.write {
                mRealm.delete(object)
            }
        }
        
        navigationButtosConfig()
        NotificationCenter.default.post(name: .notificationMovieWatchlist, object: nil)
    }
    
    @objc func didTapFavButton(sender: AnyObject){
        
        let movie = Favorites()
        
        movie.rank = getAuntoIncIntId()
        movie.id = movieId
        movie.overview = movieOverview
        movie.title = movieTitle
        movie.releaseDate = movieDate
        movie.vote_average = movieVote
        movie.posterPath = dbposterPath
        
        let object = mRealm.objects(Favorites.self).filter("id == %@", movie.id)
        
        if object.count <= 0 {
            try! mRealm.write {
                mRealm.add(movie)
            }
        } else {
            try! mRealm.write {
                mRealm.delete(object)
            }
        }
        
        navigationButtosConfig()
        NotificationCenter.default.post(name: .notificationMovieFavorites, object: nil)
    }
}

extension Notification.Name {
    static let notificationMovieFavorites = Notification.Name(rawValue: "notificationMovieFavorites")
    static let notificationMovieWatchlist = Notification.Name(rawValue: "notificationMovieWatchlist")
}
