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
    }
}

// MARK: - TableView Delegate & DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = upcomingsTableView.dequeueReusableCell(withIdentifier: CellIdentifiers.upcomingsCell.rawValue,
                                                                for: indexPath) as? UpcomingsTableViewCell
        else { return UITableViewCell()}
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.design(movie: viewModel.movies[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
}

// MARK: - View Protocol
extension MainViewController: MainViewProtocol {
    
    func prepareTableView() {
        upcomingsTableView.delegate = self
        upcomingsTableView.dataSource = self
        upcomingsTableView.register(UINib(nibName: "UpcomingsTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: CellIdentifiers.upcomingsCell.rawValue)
    }
    
    func dataRefreshed() {
        DispatchQueue.main.async {
            self.upcomingsTableView.reloadData()
        }
    }
    
    func setLoading(isLoading: Bool) {
        
    }
    
    func onError(title: String, message: String) {
        
    }
}
