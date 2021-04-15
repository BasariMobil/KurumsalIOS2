//
//  WatchListItemCell.swift
//  MoviesCatalog
//
//  Created by Yiğitcan Luş on 9.04.2021.
//

import Kingfisher
import MarkerKit
import SDWebImage

class WatchListItemCell: UITableViewCell {
    
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
    
    private func setupViews() {
        contentView.add(subviews: posterImageView, movieTitleLabel, disclosureImageView,
                        movieOverviewLabel, releaseDateView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(watchlist: Watchlist) {
        posterImageView.sd_setImage(with: URL(string: watchlist.posterPath))
        movieTitleLabel.text = watchlist.title
        movieOverviewLabel.text = watchlist.overview
        releaseDateView.setupWith(date: watchlist.releaseDate)
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

    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        movieOverviewLabel.text = nil
    }
}
