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
        router: Router,
        request: Request?
    ) -> AnyPublisher<Response, APIError> where Request: Encodable, Response: Decodable
}

class NetworkingService: NetworkingServiceProtocol {
    private let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        self.session = Session(configuration: configuration)
    }
    
    func publisherForRequest<Request, Response>(
        router: Router,
        request: Request? = nil
    ) -> AnyPublisher<Response, APIError> where Request: Encodable, Response: Decodable {
        
//        let serverDefinition: ServerDef = .emptyHeader
//        let url = URL(string: serverDefinition.baseServerURL + )!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = router.method.rawValue
        
        return session
            .request(
                APIConstants.baseURL + router.path,
                method: router.method
            )
            .publishDecodable(type: Response.self)
            .value()
            .mapError { error -> APIError in
                return APIError.noNetwork(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
