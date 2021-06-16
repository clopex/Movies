//
//  SimilarMovieCell.swift
//  Movies
//
//  Created by Adis Mulabdic on 15.06.2021..
//

import UIKit

class SimilarMovieCell: UICollectionViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ movie: MovieResult) {
        guard let posterPath = movie.poster_path else {return}
        let path = APIBase.baseImageURL + posterPath
        coverImage.setThumbnailFrom(path)
    }
}
