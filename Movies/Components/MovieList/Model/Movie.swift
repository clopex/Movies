//
//  Movie.swift
//  Movies
//
//  Created by Adis Mulabdic on 13.06.2021..
//

import Foundation

struct Movie: Decodable {
    let page: Int?
    let results: [MovieResult]?
    let total_pages: Int?
}

struct MovieResult: Decodable {
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let genre_ids: [Int]?
}
