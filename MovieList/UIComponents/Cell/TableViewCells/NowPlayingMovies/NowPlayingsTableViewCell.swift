//
//  NowPlayingsTableViewCell.swift
//  MovieList
//
//  Created by Berkay Sancar on 24.11.2022.
//

import UIKit

final class NowPlayingsTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    weak var delegate: NowPlayingCollectionViewTableViewCellDelegate?
    
    private var nowPlayingMovies: [Movie] = [] {
        didSet {
            self.pageControl.numberOfPages = nowPlayingMovies.count
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "NowPlayingCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: CellIdentifiers.nowPlayingsCVCell.rawValue)
    }
    
    func configure(movies: [Movie]) {
        self.nowPlayingMovies = movies
        self.collectionView.reloadData()
    }
}

extension NowPlayingsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nowPlayingMovies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.nowPlayingsCVCell.rawValue,
                                                            for: indexPath) as? NowPlayingCollectionViewCell else { return UICollectionViewCell()}
        
        cell.design(movie: self.nowPlayingMovies[indexPath.row])
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.width, height: self.contentView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
      }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 0
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.nowPlayingMovies[indexPath.item].id
        self.delegate?.didTapMovie(id: id)
    }
}
