//
//  APIError.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation

enum APIError : Error {
    case noData
    case noNetwork(String)
    case unknownError
    case serverError
    case statusMessage(message : String)
    case decodeError(String)
}

extension APIError {
    var desc: String {
        
        switch self {
        case .noData:                     return MessageHelper.serverError.notFound
        case .noNetwork(let error):                  return error
        case .unknownError:               return MessageHelper.serverError.general
        case .serverError:                return MessageHelper.serverError.serverError
        case .statusMessage(let message): return message
        case .decodeError(let error):     return error
        }
    }
}
