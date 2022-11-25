//
//  MainViewController.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
    func prepareTableView()
    func refreshTableView()
    func onError(title: String, message: String)
    func setLoading(isLoading: Bool)
}

protocol NowPlayingCollectionViewTableViewCellDelegate: AnyObject {
    
    func didTapMovie(id: Int)
}

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var mainTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var viewModel: MainViewModelProtocol = MainViewModel(view: self)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Actions
    @objc
    private func pullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.getUpcomingMovies(page: 1)
            self.viewModel.getNowPlayingMovies(page: 1)
            self.mainTableView.refreshControl?.endRefreshing()
        }
    }
}
// MARK: - TableView Delegate & DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.upcomingMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: CellIdentifiers.nowPlayingsTVCell.rawValue,
                                                               for: indexPath) as? NowPlayingsTableViewCell
            else { return UITableViewCell()}
            
            cell.delegate = self
            cell.configure(movies: viewModel.nowPlayingMovies)
            return cell
            
        case 1:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: CellIdentifiers.upcomingsTVCell.rawValue,
                                                               for: indexPath) as? UpcomingsTableViewCell
            else { return UITableViewCell()}
            
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            cell.design(movie: viewModel.upcomingMovies[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.view.frame.height / 2.5
        } else {
            return 136
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(movieID: viewModel.upcomingMovies[indexPath.row].id)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel.isScrolling = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if mainTableView.contentOffset.y + mainTableView.frame.size.height >= mainTableView.contentSize.height {
            viewModel.loadMoreMovies()
        }
    }
}

// MARK: - View Protocol
extension MainViewController: MainViewProtocol {
    
    func prepareTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "UpcomingsTableViewCell", bundle: nil),
                               forCellReuseIdentifier: CellIdentifiers.upcomingsTVCell.rawValue)
        mainTableView.register(UINib(nibName: "NowPlayingsTableViewCell",
                                     bundle: nil),
                               forCellReuseIdentifier: CellIdentifiers.nowPlayingsTVCell.rawValue)
        
        let refreshControl = UIRefreshControl()
        mainTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
    }
    
    func refreshTableView() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading == true {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func onError(title: String, message: String) {
        self.errorMessage(titleInput: title, messageInput: message)
    }
}

// MARK: - CollectionViewCellDelegate
extension MainViewController: NowPlayingCollectionViewTableViewCellDelegate {
    func didTapMovie(id: Int) {
        let detailVC = DetailViewController(movieID: id)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
}
