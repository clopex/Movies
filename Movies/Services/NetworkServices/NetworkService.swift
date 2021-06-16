//
//  NetworkService.swift
//  Movies
//
//  Created by Adis Mulabdic on 12.06.2021..
//

import Foundation
import Alamofire

class NetworkService: NSObject {
    
    class func sharedInstance() -> NetworkService {
        struct __ { static let _sharedInstance = NetworkService() }
        return __._sharedInstance
    }
    
    weak var delegate: ResponseServiceDelegate?
    var session: Session
    
    override init() {
        self.session = Session()
    }
    
    ///Generic method for network request where body is mandatory. Pass the correct Decodable model for parsing json!
    func request<T: Decodable, Q: Encodable>(endpoint: String, parameters: Q?, responseType: T.Type, httpMethod: HTTPMethod = .get, headers: HTTPHeaders? = nil) {
        session.request(endpoint, method: httpMethod, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: responseType) { [weak self] response in
                switch response.result {
                    case .failure(let error):
                        guard let responseData = response.data else {return}
                        let message = String(data: responseData, encoding: String.Encoding.utf8)
                        self?.delegate?.responseFailed(error, message)
                    case .success(let dataResponse):
                        
                        self?.delegate?.responseSuccess(dataResponse)
                }
            }
    }
    
    ///Generic method for network GET request. Pass the correct Decodable model for parsing json!
    func request<T: Decodable>(endpoint: String, responseType: T.Type, httpMethod: HTTPMethod = .get, headers: HTTPHeaders? = nil) {
        session.request(endpoint, method: httpMethod, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: responseType) { [weak self] response in
                switch response.result {
                    case .failure(let error):
                        guard let responseData = response.data else {return}
                        let message = String(data: responseData, encoding: String.Encoding.utf8)
                        self?.delegate?.responseFailed(error, message)
                    case .success(let dataResponse):
                        self?.delegate?.responseSuccess(dataResponse)
                }
            }
    }
}
