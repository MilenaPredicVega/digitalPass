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
    func fetchData() -> AnyPublisher<AccountResponse, APIError>
}
class CreateAccountRepositoryImpl: CreateAccountRepository {
    
    private let coreDataManager: CoreDataManager
    private let networkingService: NetworkingService
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkingService: NetworkingService, coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.networkingService = networkingService
    }
    
    func fetchData() -> AnyPublisher<AccountResponse, APIError> {
        let router = Router.getAccountData
        let request: APIRequestParameters? = nil
        return networkingService.publisherForRequest(router: router, request: request)
            .handleEvents(receiveOutput: { [weak self] data in
                self?.coreDataManager.savePassFromResponse(data)
                self?.coreDataManager.saveUserFromResponse(data)
            })
            .eraseToAnyPublisher()
    }
}
