//
//  MainViewController.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
    func dataRefreshed()
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension MainViewController: MainViewProtocol {
    
    func dataRefreshed() {
        
    }
}
