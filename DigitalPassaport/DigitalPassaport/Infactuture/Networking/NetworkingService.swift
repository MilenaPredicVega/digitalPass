//
//  NetworkingService.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Combine
import Alamofire
import Foundation

protocol NetworkingServiceProtocol {
    func publisherForRequest<Request, Response>(
        router: NetworkManager.Router,
        request: Request?
    ) -> AnyPublisher<Response, APIError> where Request: Encodable, Response: Decodable
}

class NetworkingService: NetworkingServiceProtocol {
    private let networkManager = NetworkManager()

    func publisherForRequest<Request, Response>(
        router: NetworkManager.Router,
        request: Request? = nil
    ) -> AnyPublisher<Response, APIError> where Request: Encodable, Response: Decodable {
        return networkManager.request(router: router)
            .mapError { error -> APIError in
                return APIError.noNetwork(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
