//
//  MainViewController.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
    func prepareTableView()
    func prepareCollectionView()
    func refreshTableView()
    func refreshCollectionView()
    func setLoading(isLoading: Bool)
    func onError(title: String, message: String)
}

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet private weak var upcomingsTableView: UITableView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    private lazy var viewModel: MainViewModelProtocol = MainViewModel(view: self)
    private var page: Int = 1
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        viewModel.getUpcomingMovies(page: page)
        viewModel.getNowPlayingMovies(page: page)
    }
    
// MARK: - Actions
    @objc
    private func pullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.viewModel.getUpcomingMovies(page: 1)
            self.upcomingsTableView.refreshControl?.endRefreshing()
        }
    }
}
// MARK: - TableView Delegate & DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = upcomingsTableView.dequeueReusableCell(withIdentifier: CellIdentifiers.upcomingsCell.rawValue,
                                                                for: indexPath) as? UpcomingsTableViewCell
        else { return UITableViewCell()}
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.design(movie: viewModel.upcomingMovies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(movieID: viewModel.upcomingMovies[indexPath.row].id)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            self.page += 1
            viewModel.getUpcomingMovies(page: page)
        }
    }
}

// MARK: - CollectionView Delegate & DataSource & Flowlayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = nowPlayingCollectionView.dequeueReusableCell(
            withReuseIdentifier: CellIdentifiers.nowPlayingCell.rawValue,
            for: indexPath) as? NowPlayingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.design(movie: viewModel.nowPlayingMovies[indexPath.row])
        pageControl.numberOfPages = viewModel.nowPlayingMovies.count
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController(movieID: viewModel.nowPlayingMovies[indexPath.item].id)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
}
// MARK: - View Protocol
extension MainViewController: MainViewProtocol {
    
    func prepareTableView() {
        upcomingsTableView.delegate = self
        upcomingsTableView.dataSource = self
        upcomingsTableView.register(UINib(nibName: "UpcomingsTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: CellIdentifiers.upcomingsCell.rawValue)
        
        let refreshControl = UIRefreshControl()
        upcomingsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
    }
    
    func prepareCollectionView() {
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.register(UINib(nibName: "NowPlayingCollectionViewCell",
                                                bundle: nil),
                                          forCellWithReuseIdentifier: CellIdentifiers.nowPlayingCell.rawValue)
    }
    
    func refreshTableView() {
        DispatchQueue.main.async {
            self.upcomingsTableView.reloadData()
        }
    }
    
    func refreshCollectionView() {
        DispatchQueue.main.async {
            self.nowPlayingCollectionView.reloadData()
        }
    }
    
    func setLoading(isLoading: Bool) {
        
    }
    
    func onError(title: String, message: String) {
        self.errorMessage(titleInput: title, messageInput: message)
    }
}
