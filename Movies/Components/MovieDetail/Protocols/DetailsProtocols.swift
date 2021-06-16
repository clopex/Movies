//
//  DetailsProtocols.swift
//  Movies
//
//  Created by Adis Mulabdic on 15.06.2021..
//

import Foundation

protocol DetailMovieDelegate: AnyObject {
    func completed(_ message: String?)
    func similar(_ loaded: Bool)
}
