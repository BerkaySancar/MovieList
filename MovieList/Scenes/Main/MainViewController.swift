//
//  MainViewController.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
    func dataRefreshed()
    func prepareTableView()
    func prepareCollectionView()
    func setLoading(isLoading: Bool)
    func onError(title: String, message: String)
}

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet private weak var upcomingsTableView: UITableView!
    
    private lazy var viewModel: MainViewModelProtocol = MainViewModel(view: self)
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        viewModel.getUpcomingMovies(page: 1)
        viewModel.getNowPlayingMovies(page: 1)
    }
// MARK: - Status Bar Color
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
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
        
        // to do
        let viewController = DetailViewController(nibName: "DetailView", bundle: nil)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = nowPlayingCollectionView.dequeueReusableCell(
            withReuseIdentifier: CellIdentifiers.nowPlayingCell.rawValue,
            for: indexPath) as? NowPlayingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.design(movie: viewModel.nowPlayingMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
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
    
    func dataRefreshed() {
        DispatchQueue.main.async {
            self.upcomingsTableView.reloadData()
            self.nowPlayingCollectionView.reloadData()
        }
    }
    
    func setLoading(isLoading: Bool) {
        
    }
    
    func onError(title: String, message: String) {
        
    }
}
