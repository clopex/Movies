//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Adis Mulabdic on 13.06.2021..
//

import Foundation

class MovieViewModel: BaseViewModel {
    var page = 1
    var movie: Movie?
    var movies: [MovieResult] = []
    var sortTaped = false
    
    weak var delegate: MoviesFetchedDelegate?
    
    var movieSort = MovieSort.topRated {
        didSet {
            sortTaped = true
            page = 1
            movies.removeAll()
            fetchMovies()
        }
    }
    
    static func build() -> MovieViewModel {
        return MovieViewModel(service: NetworkService.sharedInstance())
    }
    
    private func fillMovies() {
        guard let movie = movie else {return}
        guard let results = movie.results else {return}
        self.movies.append(contentsOf: results)
        delegate?.success(nil)
        if sortTaped {
            delegate?.scroll()
        }
    }
    
    func fetchMovies() {
        var endpoint = API.completeURL(.popularMovies, with: page)
        if movieSort == .topRated {
            endpoint = API.completeURL(.topRatedMovies, with: page)
        }
        
        networkService.delegate = self
        networkService.request(endpoint: endpoint, responseType: Movie.self)
    }
    
    func getId(from row: Int) -> Int {
        guard let id = movies[row].id else {return 0}
        return id
    }
}

//MARK: Network Response
extension MovieViewModel: ResponseServiceDelegate {
    func responseSuccess<T>(_ response: T?) where T : Decodable {
        if let res = response as? Movie {
            self.movie = res
            
            fillMovies()
        }
    }
    
    func responseFailed(_ error: Error?, _ message: String?) {
        delegate?.success(message)
    }
}

enum MovieSort {
    case popular
    case topRated
}
