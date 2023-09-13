//
//  NetworkingService.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Combine
import Alamofire
import Foundation

class NetworkingService {
    private let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        self.session = Session(configuration: configuration)
    }
    
    func publisherForRequest<Input: Encodable, Response: Decodable>(router: NetworkRoutable,
                                                                    request: Input? = nil,
                                                                    responseType: Response.Type,
                                                                    encoder: NetworkParameterEncoder? = nil)
                                                                            -> AnyPublisher<Response, APIError> {
        let encoder = encoder?.getEncoder() ?? NetworkParameterEncoder.getDefaultEncoder()
        return session
            .request(
                router.url,
                method: router.method,
                parameters: request,
                encoder: encoder,
                headers: router.headers)
            .validate()
            .publishDecodable(type: Response.self)
            .value()
            .mapError { error -> APIError in
                return APIError.noNetwork(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
