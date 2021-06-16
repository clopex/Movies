//
//  BaseViewModel.swift
//  Movies
//
//  Created by Adis Mulabdic on 13.06.2021..
//

import Foundation

class BaseViewModel {
    var networkService: NetworkService
    
    init(service: NetworkService) {
        self.networkService = service
    }
}
