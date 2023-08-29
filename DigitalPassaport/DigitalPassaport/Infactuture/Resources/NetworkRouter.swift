//
//  NetworkRouter.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Alamofire

protocol NetworkRoutable {
    var method: HTTPMethod { get }
    var path: String { get }
}

enum Router: NetworkRoutable {
    case getAccountData
    case updateCredentials

    var path: String {
        switch self {
        case .getAccountData:
            return "/account"
        case .updateCredentials:
            return "/credentials"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getAccountData, .updateCredentials:
            return .post
        }
    }
}
