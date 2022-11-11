//
//  DetailViewController.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    
    func setLoading(isLoading: Bool)
}

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .label
    }
}
