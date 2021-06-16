//
//  MovieProtocols.swift
//  Movies
//
//  Created by Adis Mulabdic on 13.06.2021..
//

import Foundation

protocol MoviesFetchedDelegate: AnyObject {
    func success(_ message: String?)
    func scroll()
}
