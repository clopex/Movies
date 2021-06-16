//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Adis Mulabdic on 15.06.2021..
//

import Foundation

class MovieDetailViewModel: BaseViewModel {
    
    var movieId: Int?
    var details: MovieDetails?
    var page = 1
    var movie: Movie?
    var movies: [MovieResult] = []
    
    weak var delegate: DetailMovieDelegate?
    
    static func build() -> MovieDetailViewModel {
        return MovieDetailViewModel(service: NetworkService.sharedInstance())
    }
    
    func getDetails() {
        guard let id = movieId else {return}
        let endpoint = API.completeURL(.movieDetails(id: id))
        networkService.delegate = self
        networkService.request(endpoint: endpoint, responseType: MovieDetails.self)
    }
    
    func fetchSimilarMovies() {
        guard let id = movieId else {return}
        let endpoint = API.completeURL(.similarMovies(id: id), with: page)
        networkService.delegate = self
        networkService.request(endpoint: endpoint, responseType: Movie.self)
    }
    
    func getTitle() -> String {
        guard let details = details else {return ""}
        guard let title = details.title else {return ""}
        return title
    }
    
    func getOverview() -> String {
        guard let details = details else {return ""}
        guard let overview = details.overview else {return ""}
        return overview
    }
    
    func getCoverImagePath() -> String {
        guard let details = details else {return ""}
        guard let backdrop_path = details.backdrop_path else {return ""}
        return backdrop_path
    }
    
    func getReleaseDate() -> String {
        guard let details = details else {return ""}
        guard let release_date = details.release_date else {return ""}
        return release_date
    }
    
    func getPosterImagePath() -> String {
        guard let details = details else {return ""}
        guard let poster_path = details.poster_path else {return ""}
        return poster_path
    }
    
    func getGenres() -> [String] {
        guard let details = details else {return []}
        guard let genres = details.genres else {return []}
        
        return genres.map{$0.name!}
    }
    
    func isEndOfPagination() -> Bool {
        guard let totalPages = movie?.total_pages else {return true}
        return page == totalPages
    }
    
    private func fillMovies() {
        guard let movie = movie else {return}
        guard let results = movie.results else {return}
        self.movies.append(contentsOf: results)
        delegate?.similar(true)
    }
}

//MARK: Network Response 
extension MovieDetailViewModel: ResponseServiceDelegate {
    func responseSuccess<T>(_ response: T?) where T : Decodable {
        if let res = response as? MovieDetails {
            self.details = res
            delegate?.completed(nil)
        }
        if let res = response as? Movie {
            self.movie = res
            fillMovies()
        }
    }
    
    func responseFailed(_ error: Error?, _ message: String?) {
        delegate?.completed(message)
    }
}
