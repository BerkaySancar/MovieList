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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func design(movie: Movie) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")") {
            posterImageView.sd_setImage(with: url)
        }
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }
}
