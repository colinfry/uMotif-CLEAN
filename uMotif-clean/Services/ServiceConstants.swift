//
//  ServiceError.swift
//  uMotif-clean
//
//  Created by Colin Fry on 26/03/2022.
//

import Foundation

enum ServiceError: Error {
    case urlError
    case requestError
    case statusError
    case decodingError
    case generalError
}

enum ServiceEndpoints: String {
    case cnJokes = "https://api.icndb.com/jokes/random/55?exclude=[explicit]"
}
