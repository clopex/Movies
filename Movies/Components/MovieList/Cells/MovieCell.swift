//
//  MovieCell.swift
//  Movies
//
//  Created by Adis Mulabdic on 13.06.2021..
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(_ cell: MovieResult) {
        guard let title = cell.title else {return}
        guard let posterPath = cell.poster_path else {return}
        movieTitle.text = title
        let path = APIBase.baseImageURL + posterPath
        movieImage.setThumbnailFrom(path)
    }
    
}
