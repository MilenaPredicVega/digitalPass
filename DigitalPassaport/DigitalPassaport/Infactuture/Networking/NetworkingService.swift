//
//  NetworkingService.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation
import Combine
import Alamofire

protocol NetworkingServiceProtocol {
    func post<T: Decodable, Request: Encodable>(
        url: URL,
        parameters: Request?
    ) -> AnyPublisher<T, APIError>
}

class NetworkingService: NetworkingServiceProtocol {
    
    private let alamofireSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration)
      }()

    func post<T, Request>(url: URL, parameters: Request?) -> AnyPublisher<T, APIError> where T : Decodable, Request : Encodable {
        return alamofireSession
            .request(url, method: .post, parameters: parameters)
            .publishDecodable(type: T.self)
            .mapError { error -> APIError in
                return error
            }
            .flatMap { response -> AnyPublisher<T, APIError> in
                if let value = response.value {
                    return Just(value)
                        .setFailureType(to: APIError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.noData).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
