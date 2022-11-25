//
//  UpcomingsTableViewCell.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import SDWebImage
import UIKit

final class UpcomingsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func design(movie: Movie) {
        let url = URL(string: MovieListEndpoints.imageUrl(posterPath: movie.posterPath ?? "").url)
        posterImageView.sd_setImage(with: url)
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd" // Format of API Date
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd.MM.yyyy" // Desired Format

        let date = dateFormatter1.date(from: movie.releaseDate ?? "") ?? Date()
        let desiredFormat = dateFormatter2.string(from: date)
        
        dateLabel.text = desiredFormat
    }
}
