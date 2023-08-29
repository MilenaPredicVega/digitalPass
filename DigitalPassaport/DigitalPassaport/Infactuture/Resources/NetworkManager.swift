//
//  NetworkRoutable.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//
import Foundation
import Combine
import Alamofire

class NetworkManager {
    private let session: Session

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        session = Session(configuration: configuration)
    }

    private let baseUrl = "http://localhost:5005/"

    enum Router {
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

    func request<Response>(
        router: Router
    ) -> AnyPublisher<Response, AFError> where Response: Decodable {
        return session
            .request(
                baseUrl + router.path,
                method: router.method
            )
            .publishDecodable(type: Response.self)
            .value()
            .eraseToAnyPublisher()
    }
}
