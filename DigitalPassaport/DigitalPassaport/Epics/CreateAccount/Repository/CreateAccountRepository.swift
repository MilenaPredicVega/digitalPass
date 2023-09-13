//
//  CreateAccountRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 24.8.23..
//

import Foundation
import Combine
import Alamofire

protocol CreateAccountRepository {
    func fetchData() -> AnyPublisher<Void, APIError>
}
class CreateAccountRepositoryImpl: CreateAccountRepository {
    
    private let networkingService: NetworkingService
    private let coreDataManager: CoreDataManager
    
    init(networkingService: NetworkingService, coreDataManager: CoreDataManager) {
        self.networkingService = networkingService
        self.coreDataManager = coreDataManager
    }
    
    
    func fetchData() -> AnyPublisher<Void, APIError> {
        networkingService.publisherForRequest(router: AccountRouter.getAccountData,
                                              request: Optional<EmptyRequest>.none,
                                              responseType: AccountResponse.self)
        .flatMap({ [weak self] (response: AccountResponse) -> AnyPublisher<Void, APIError> in
            guard let self else {
                return Fail(error: APIError.noData).eraseToAnyPublisher()
            }
            
            return coreDataManager.savePassFromResponse(response)
                .zip(coreDataManager.saveUserFromResponse(response))
                .map { _, _ in () }
                .eraseToAnyPublisher()
        })
        .eraseToAnyPublisher()
    }
}

struct EmptyRequest: Encodable {}
