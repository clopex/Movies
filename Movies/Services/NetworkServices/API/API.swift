//
//  API.swift
//  Movies
//
//  Created by Adis Mulabdic on 12.06.2021..
//

import Foundation

struct APIBase {
    static let baseURL = "https://api.themoviedb.org/3"
    static let baseImageURL = "https://image.tmdb.org/t/p/w400"
}

class API {
    static let apiKey = "fe3b8cf16d78a0e23f0c509d8c37caad"
    static let baseUrl = APIBase.baseURL
    static let baseImageUrl = APIBase.baseImageURL
    
    static func completeURL(_ endpoint: Endpoint, with page: Int? = nil) -> String {
        var urlComponents = URLComponents()
        urlComponents.path = endpoint.endpoint
        var urlQueryItems = [
            URLComponent.createQueryItem(item: .apiKey, and: API.apiKey),
        ]
        if let page = page {
            let query = URLComponent.createQueryItem(item: .page, and: "\(page)")
        urlQueryItems.append(query)
        }
        urlComponents.queryItems = urlQueryItems
        
        return API.baseUrl + urlComponents.url!.absoluteString
    }
    
    enum Endpoint {
        case popularMovies
        case topRatedMovies
        case movieDetails(id: Int)
        case similarMovies(id: Int)
        
        var endpoint: String {
            switch self {
                case .popularMovies:
                    return "/movie/popular"
                case .topRatedMovies:
                    return "/movie/top_rated"
                case .movieDetails(id: let id):
                    return "/movie/\(id)"
                case .similarMovies(id: let id):
                    return "/movie/\(id)/similar"
            }
        }
    }
    
    static func createUrl(endpoint: Endpoint) -> String {
        return "\(API.baseUrl)\(endpoint.endpoint)"
    }
}

class URLComponent {
    enum QueryItem {
        case page
        case limit
        case apiKey
        
        var item: String {
            switch self {
                case .apiKey:
                    return "api_key"
                case .page:
                    return "page"
                case .limit:
                    return "limit"
            }
        }
    }
    
    static func createQuery(item: QueryItem, and data: String) -> [String: String] {
        return [item.item: data]
    }
    
    static func createQueryItem(item: QueryItem, and data: String) -> URLQueryItem {
        return URLQueryItem(name: item.item, value: data)
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
