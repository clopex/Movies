//
//  NetworkProtocol.swift
//  Movies
//
//  Created by Adis Mulabdic on 12.06.2021..
//

import Foundation

protocol ResponseServiceDelegate: AnyObject {
    func responseSuccess<T: Decodable>(_ response: T?)
    func responseFailed(_ error: Error?, _ message: String?)
}
