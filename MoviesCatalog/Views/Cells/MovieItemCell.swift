//
//  MovieItemCell.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import UIKit

import Kingfisher
import MarkerKit

final class MovieItemCell: UITableViewCell {
    
    private struct Sizes {
        static let posterDefaultWidth: CGFloat = 125
        static let posterDefaultHeight: CGFloat = 188
    }
    
    private let posterImageView = UIImageView(contentMode: .scaleToFill)
    private let movieTitleLabel = UILabel(font: .systemFont(ofSize: 17, weight: .semibold), backgroundColor: .clear, lines: 1)
    private let disclosureImageView = UIImageView(image: Image.by(assetId: .disclosureIndicator))
    private let movieOverviewLabel = UILabel(font: .systemFont(ofSize: 14, weight: .light), backgroundColor: .clear)
    private let releaseDateView = MovieYearReleaseView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.add(subviews: posterImageView, movieTitleLabel, disclosureImageView,
                        movieOverviewLabel, releaseDateView)
    }
    
    private func setupConstraints() {
        posterImageView.mrk.top(to: contentView, attribute: .top, relation: .equal, constant: 5)
        posterImageView.mrk.leading(to: contentView, attribute: .leading, relation: .equal, constant: 0)
        posterImageView.mrk.width(Sizes.posterDefaultWidth)
        posterImageView.mrk.height(Sizes.posterDefaultHeight)

        movieTitleLabel.mrk.top(to: contentView, attribute: .top, relation: .equal, constant: 6)
        movieTitleLabel.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 12)
        movieTitleLabel.mrk.trailing(to: disclosureImageView, attribute: .leading, relation: .equal, constant: -13)

        disclosureImageView.mrk.trailing(to: contentView, attribute: .trailing, relation: .equal, constant: -19)
        disclosureImageView.mrk.width(8)
        disclosureImageView.mrk.centerY(to: movieTitleLabel)

        movieOverviewLabel.mrk.top(to: movieTitleLabel, attribute: .bottom, relation: .equal, constant: 4)
        movieOverviewLabel.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 12)
        movieOverviewLabel.mrk.trailing(to: contentView, attribute: .trailing, relation: .equal, constant: -19)
        movieOverviewLabel.mrk.bottom(to: releaseDateView, attribute: .top, relation: .lessThanOrEqual, constant: -6)

        movieOverviewLabel.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)

        releaseDateView.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 12)
        releaseDateView.mrk.bottom(to: contentView, attribute: .bottom, relation: .equal, constant: -6)
    }

    func setup(with movie: Movie) {
        if let path = movie.posterPath, let imageBaseUrl = URL(string: Config.URL.basePoster) {
            let posterPath = imageBaseUrl
                .appendingPathComponent("w300")
                .appendingPathComponent(path)

            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(
                with: posterPath,
                options: [.transition(.fade(0.2))]
            ) { [weak self] _ in
                    self?.contentView.layoutIfNeeded()
            }
        }
        
        movieTitleLabel.text    = movie.title
        movieOverviewLabel.text = movie.overview

        releaseDateView.setupWith(date: movie.releaseDate)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        movieOverviewLabel.text = nil
    }
}
