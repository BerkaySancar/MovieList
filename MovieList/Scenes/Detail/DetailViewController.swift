//
//  DetailViewController.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    
    func setLoading(isLoading: Bool)
    func showMovie(movie: Movie)
}

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    private lazy var viewModel: DetailViewModelProtocol = DetailViewModel(view: self)
    private(set) var movieID: Int?
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: "DetailView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .label
        
        viewModel.getMovieDetail(id: movieID ?? 0)
    }
}

extension DetailViewController: DetailViewProtocol {
    func setLoading(isLoading: Bool) {
    }
    
    func showMovie(movie: Movie) {
        let url = URL(string: MovieListEndpoints.imageUrl(posterPath: movie.posterPath ?? "").url)
        posterImageView.sd_setImage(with: url)
        titleLabel.text = movie.title ?? ""
        overviewLabel.text = movie.overview ?? ""
        // MARK: To do
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd" // Format of API Date
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd.MM.yyyy" // Desired Format

        let date = dateFormatter1.date(from: movie.releaseDate ?? "") ?? Date()
        let desiredFormat = dateFormatter2.string(from: date)
        dateLabel.text = desiredFormat
    }
}
