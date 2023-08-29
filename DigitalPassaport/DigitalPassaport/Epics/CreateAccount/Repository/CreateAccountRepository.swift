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
    func fetchData() -> AnyPublisher<AccountResponse, Error>
}
class CreateAccountRepositoryImpl: CreateAccountRepository {
    
    private let coreDataManager: CoreDataManager
    private let networkingService: NetworkingService
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkingService: NetworkingService, coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.networkingService = networkingService
    }
    
    func fetchData() -> AnyPublisher<AccountResponse, Error> {
        let router = NetworkManager.Router.getAccountData
        let request: APIRequestParameters? = nil
        return networkingService.publisherForRequest(router: router, request: request)
            .tryMap { accountResponse -> AccountResponse in
                self.coreDataManager.savePassFromResponse(accountResponse)
                self.coreDataManager.saveUserFromResponse(accountResponse)
                return accountResponse
            }
            .eraseToAnyPublisher()
    }
}
