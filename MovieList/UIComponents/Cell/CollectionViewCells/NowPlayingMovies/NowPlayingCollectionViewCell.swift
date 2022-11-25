//
//  NowPlayingCollectionViewCell.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import UIKit
import SDWebImage

final class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    func design(movie: Movie) {
        let url = URL(string: MovieListEndpoints.imageUrl(posterPath: movie.posterPath ?? "").url)
        posterImageView.sd_setImage(with: url)
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }
}
