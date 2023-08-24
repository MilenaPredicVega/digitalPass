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
    func post(_ url: URL, parameters: [String: Any]) -> AnyPublisher<Data, APIError>
}

class NetworkingService: NetworkingServiceProtocol {
    
    func post(_ url: URL, parameters: [String: Any]) -> AnyPublisher<Data, APIError> {
        return AF.request(url, method: .post, parameters: parameters)
            .publishData()
            .mapError { error -> APIError in
                return error
            }
            .flatMap { dataResponse -> AnyPublisher<Data, APIError> in
                if let data = dataResponse.data {
                    return Just(data)
                        .setFailureType(to: APIError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .noNetwork).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

