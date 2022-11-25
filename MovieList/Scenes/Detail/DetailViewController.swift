//
//  DetailViewController.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import SafariServices
import UIKit

protocol DetailViewProtocol: AnyObject {
    
    func setLoading(isLoading: Bool)
    func showMovie(movie: Movie)
    func setNavTitle(title: String)
    func onError(title: String, message: String)
}

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navTitleLabel: UILabel!
    
    private lazy var viewModel: DetailViewModelProtocol = DetailViewModel(view: self)
    private var movieID: Int!
    
    // MARK: - Init
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: "DetailView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad(id: movieID)
        self.navigationController?.navigationBar.tintColor = .label
    }
    // MARK: - Actions
    @IBAction private func backButtonTapped(_ sender: Any) {
        let mainVC = MainViewController(nibName: "MainView", bundle: nil)
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
    
    @IBAction private func imdbButtonTapped(_ sender: Any) {
        if let url = URL(string: MovieListEndpoints.imdbWebsite(id: viewModel.movie?.imdbID ?? "").url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
        }
    }
}
// MARK: - View Protocol
extension DetailViewController: DetailViewProtocol {
    
    func setLoading(isLoading: Bool) {
        if isLoading == false {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        } else {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func setNavTitle(title: String) {
        self.navTitleLabel.text = title
    }
    
    func showMovie(movie: Movie) {
        let url = URL(string: MovieListEndpoints.imageUrl(posterPath: movie.posterPath ?? "").url)
        posterImageView.sd_setImage(with: url)
        titleLabel.text = movie.title ?? ""
        overviewLabel.text = movie.overview ?? ""
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd" // Format of API Date
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd.MM.yyyy" // Desired Format
        
        let date = dateFormatter1.date(from: movie.releaseDate ?? "") ?? Date()
        let desiredFormat = dateFormatter2.string(from: date)
        dateLabel.text = desiredFormat
        rateLabel.text = String(movie.voteAverage ?? 0)
    }
    
    func onError(title: String, message: String) {
        self.errorMessage(titleInput: title, messageInput: message)
    }
}
