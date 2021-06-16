//
//  UIImageViewExt.swift
//  Movies
//
//  Created by Adis Mulabdic on 14.06.2021..
//

import UIKit
import Kingfisher

extension UIImageView {
    func setThumbnailFrom(_ url: String) {
        let urlImage = URL(string: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: urlImage)
    }
}
