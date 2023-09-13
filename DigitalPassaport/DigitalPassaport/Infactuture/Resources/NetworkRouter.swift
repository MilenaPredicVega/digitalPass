//
//  NetworkRouter.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//
import Alamofire
import Foundation

protocol NetworkRoutable {
    var headers: HTTPHeaders? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var url: String { get }
    var encoder: NetworkParameterEncoder { get }
}

enum AccountRouter: NetworkRoutable {
    case getAccountData
    case updateCredentials
    
    var headers: HTTPHeaders? {
        switch self {
        case .getAccountData:
            return ["Accept": "application/json"]
        case .updateCredentials:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }

    var url: String {
        switch self {
        case .getAccountData, .updateCredentials:
            return APIConstants.baseURL + path
        }
    }
    
    var encoder: NetworkParameterEncoder {
        switch self {
        case .getAccountData, .updateCredentials:
            return .json
        }
    }
    
    var path: String {
        switch self {
        case .getAccountData:
            return "/account"
        case .updateCredentials:
            return "/credential"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAccountData, .updateCredentials:
            return .post
        }
    }
}

