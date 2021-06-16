//
//  MovieDetails.swift
//  Movies
//
//  Created by Adis Mulabdic on 15.06.2021..
//

import Foundation

struct MovieDetails: Decodable {
    let adult: Bool?
    let backdrop_path: String?
    let genres: [MovieGenre]?
    let id: Int?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let title: String?
}

struct MovieGenre: Decodable {
    let id: Int?
    let name: String?
}
